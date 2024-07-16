import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/services.dart';

// Para el mapa
Future<Uint8List> getCircleImage(Uint8List imageBytes) async {
  final codec = await ui.instantiateImageCodec(imageBytes);
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
