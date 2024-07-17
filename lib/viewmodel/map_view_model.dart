import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dornas_app/services/map_service.dart';
import 'package:dornas_app/services/user_service.dart';
import 'package:dornas_app/ui/widgets/custom_tileprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// ViewModel para el mapa
class MapViewModel extends ChangeNotifier {
  final MapService _mapService = MapService();
  final UserService _userService = UserService();
  final DefaultCacheManager _cacheManager = DefaultCacheManager();

  LatLng? _currentLocation;
  LatLng? get currentLocation => _currentLocation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<QuerySnapshot>? _usersStreamSubscription;

  dynamic _selectedMapType = MapType.normal;
  dynamic get selectedMapType => _selectedMapType;

  final Set<Polyline> _polylines = {};
  Set<Polyline> get polylines => _polylines;

  TileOverlay? _openSeaMapTileOverlay;
  TileOverlay? get openSeaMapTileOverlay => _openSeaMapTileOverlay;

  TileOverlay? _baseMapTileOverlay;
  TileOverlay? get baseMapTileOverlay => _baseMapTileOverlay;

  bool _isOpenSeaMap = false;
  bool get isOpenSeaMap => _isOpenSeaMap;

  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Cambia el tipo de mapa
  void setMapType(dynamic mapType) {
    if (mapType == 'openseamap') {
      _selectedMapType = 'openseamap';
      _openSeaMapTileOverlay = TileOverlay(
        tileOverlayId: const TileOverlayId('openseamap'),
        tileProvider: CustomUrlTileProvider(
          urlTemplate: 'https://tiles.openseamap.org/seamark/{z}/{x}/{y}.png',
        ),
      );
      _baseMapTileOverlay = TileOverlay(
        tileOverlayId: const TileOverlayId('openseamap_base'),
        tileProvider: CustomUrlTileProvider(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        ),
      );
      _isOpenSeaMap = true;
    } else {
      _selectedMapType = mapType;
      _openSeaMapTileOverlay = null;
      _baseMapTileOverlay = null;
      _isOpenSeaMap = false;
    }
    notifyListeners();
  }

  // Inicia la transmisión de ubicación
  void startLocationUpdates() {
  _positionStreamSubscription = _mapService.getCurrentLocationStream().listen(
    (Position position) async {
      print('Nueva posición: ${position.latitude}, ${position.longitude}');
      _currentLocation = LatLng(position.latitude, position.longitude);
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        await _mapService.updateUserLocation(userId, position);
      }
      _addCurrentUserMarker();
      notifyListeners();
    },
    onError: (e) {
      setMessage(e.toString());
    },
  );

  _usersStreamSubscription = FirebaseFirestore.instance.collection('users').snapshots().listen(
    (QuerySnapshot snapshot) {
      _markers.clear();
      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        final location = data['location'] as GeoPoint?;
        final displayName = data['displayName'] as String?;
        final photoUrl = data['photoUrl'] as String?;

        if (location != null && displayName != null && photoUrl != null) {
          _addUserMarker(doc.id, LatLng(location.latitude, location.longitude), displayName, photoUrl);
        }
      }
      notifyListeners();
    },
    onError: (e) {
      setMessage(e.toString());
    },
  );
}

  // Detiene la transmisión de ubicación
  void stopLocationUpdates() {
    _positionStreamSubscription?.cancel();
    _usersStreamSubscription?.cancel();
  }

  // Añade una polilínea
  void addPolyline(List<LatLng> points) {
    final polyline = Polyline(
      polylineId: PolylineId(DateTime.now().toIso8601String()),
      points: points,
      color: Colors.blue,
      width: 5,
    );
    _polylines.add(polyline);
    notifyListeners();
  }

  // Limpia las polilíneas
  void clearPolylines() {
    _polylines.clear();
    notifyListeners();
  }

  // Añade un la foto de perfil del usuario correspondiente a su localización
 Future<void> _addCurrentUserMarker() async {
    if (_currentLocation != null) {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        final photoUrl = await _userService.getUserProfileImageUrl(userId);
        final user = await _userService.getUser(userId);
        if (photoUrl != null && user != null) {
          Uint8List bytes;
          try {
            final file = await _cacheManager.getSingleFile(photoUrl);
            bytes = file.readAsBytesSync();
          } catch (e) {
            bytes = await _downloadImageBytes(photoUrl);
          }

          // Convert the image to a circle
          final circleImageBytes = await getCircleImage(bytes);

          final bitmapDescriptor = await _getBytesAsBitmapDescriptor(circleImageBytes);

          // Remove the existing marker if any
          _markers.removeWhere((marker) => marker.markerId.value == userId);

          // Add the new marker
          final marker = Marker(
            markerId: MarkerId(userId),
            position: _currentLocation!,
            icon: bitmapDescriptor,
            infoWindow: InfoWindow(title: user.displayName ?? 'Usuario'),
          );
          _markers.add(marker);
          notifyListeners();
        }
      }
    }
  }

  // Añade un marcador de usuario
  Future<void> _addUserMarker(String userId, LatLng position, String displayName, String photoUrl) async {
    Uint8List bytes;
    try {
      final file = await _cacheManager.getSingleFile(photoUrl);
      bytes = file.readAsBytesSync();
    } catch (e) {
      bytes = await _downloadImageBytes(photoUrl);
    }

    final circleImageBytes = await getCircleImage(bytes);
    final bitmapDescriptor = await _getBytesAsBitmapDescriptor(circleImageBytes);

    // Remove the existing marker if any
    _markers.removeWhere((marker) => marker.markerId.value == userId);

    // Add the new marker
    final marker = Marker(
      markerId: MarkerId(userId),
      position: position,
      icon: bitmapDescriptor,
      infoWindow: InfoWindow(title: displayName),
    );
    _markers.add(marker);
  }

  // Descarga la imagen
  Future<Uint8List> _downloadImageBytes(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw ('Error al descargar la imagen');
    }
  }

  // Convierte los bytes en un BitmapDescriptor
  Future<BitmapDescriptor> _getBytesAsBitmapDescriptor(Uint8List bytes) async {
    final codec = await instantiateImageCodec(bytes, targetWidth: 100);
    final frame = await codec.getNextFrame();
    final data = await frame.image.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }

  // Convierte la imagen en un círculo
  Future<Uint8List> getCircleImage(Uint8List imageBytes) async {
    final codec = await instantiateImageCodec(imageBytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final paint = Paint();
    final size = image.width.toDouble();

    paint.shader = ImageShader(
      image,
      TileMode.clamp,
      TileMode.clamp,
      Matrix4.identity().storage,
    );

    final path = Path()
      ..addOval(Rect.fromLTWH(0, 0, size, size))
      ..close();

    canvas.clipPath(path);
    canvas.drawPaint(paint);

    final picture = pictureRecorder.endRecording();
    final img = await picture.toImage(image.width, image.height);
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  void dispose() {
    stopLocationUpdates();
    super.dispose();
  }
}
