import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker {
  static List<String> splitIntoTwo(String text) {
    final parts = text.split(' ');
    final middle = (parts.length / 2).ceil();
    final firstPart = parts.sublist(0, middle).join(' ');
    final secondPart = parts.sublist(middle).join(' ');
    return [firstPart, secondPart];
  }

  static Future<BitmapDescriptor> create({required String text}) async {
    const double circleRadius = 90;
    const double stemHeight = 70;
    const double smallCircleRadius = 22;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    final paintBlack = Paint()..color = Colors.black;
    final paintGrey = Paint()..color = const Color(0xFF9E9E9E);

    final centerX = circleRadius;
    final centerY = circleRadius;

    canvas.drawCircle(Offset(centerX, centerY), circleRadius, paintBlack);

    canvas.drawRect(
      Rect.fromLTWH(centerX - 6, centerY + circleRadius, 12, stemHeight),
      paintGrey,
    );

    canvas.drawCircle(
      Offset(centerX, centerY + circleRadius + stemHeight),
      smallCircleRadius,
      paintBlack,
    );

    canvas.drawCircle(
      Offset(centerX, centerY + circleRadius + stemHeight),
      smallCircleRadius - 6,
      Paint()..color = Colors.white,
    );
    final parts = splitIntoTwo(text);
    final textPainter = TextPainter(
      text: TextSpan(
        children: [
          TextSpan(
            text: parts[0],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(text: '\n'),
          TextSpan(
            text: parts[1],
            style: const TextStyle(color: Colors.white, fontSize: 28),
          ),
        ],
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: circleRadius * 2);
    textPainter.paint(
      canvas,
      Offset(centerX - textPainter.width / 2, centerY - textPainter.height / 2),
    );

    final image = await recorder.endRecording().toImage(
      (circleRadius * 2).toInt(),
      (circleRadius * 2 + stemHeight + smallCircleRadius * 2).toInt(),
    );

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }

  static Future<BitmapDescriptor> createCircleHoleMarker({
    double outerRadius = 32,
    double innerRadius = 16,
    Color outerColor = Colors.white,
    Color innerColor = Colors.black,
    Color shadowColor = const Color(0x55000000),
    double shadowBlur = 12,
    Offset shadowOffset = const Offset(2, 2),
  }) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final size = Size(
      outerRadius * 2 + shadowBlur * 2,
      outerRadius * 2 + shadowBlur * 2,
    );
    final center = Offset(size.width / 2, size.height / 2);

    final shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);
    canvas.drawCircle(center + shadowOffset, outerRadius, shadowPaint);

    final outerPaint = Paint()
      ..color = outerColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, outerRadius, outerPaint);

    final innerPaint = Paint()
      ..color = innerColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, innerRadius, innerPaint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);

    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }
}
