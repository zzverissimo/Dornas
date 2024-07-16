import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Proveedor de teselas personalizado
class CustomUrlTileProvider extends TileProvider {
  final String urlTemplate;

  CustomUrlTileProvider({required this.urlTemplate});

  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    final url = urlTemplate
        .replaceAll('{z}', zoom.toString())
        .replaceAll('{x}', x.toString())
        .replaceAll('{y}', y.toString());
    try {
      final response = await NetworkAssetBundle(Uri.parse(url)).load(url);
      final bytes = response.buffer.asUint8List();
      return Tile(256, 256, bytes);
    } catch (e) {
      return const Tile(256, 256, null);
    }
  }
}