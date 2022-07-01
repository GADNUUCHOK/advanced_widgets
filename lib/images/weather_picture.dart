import 'package:flutter/material.dart';

class SunCloudRain extends CustomPainter {
  double opacity;
  double? opacitySun;
  double? opacityCloud;
  double? opacityDrop;

  SunCloudRain(this.opacity);

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity > 0.7) {
      opacityDrop = 10 / 3 * opacity - 7 / 3;
      opacityCloud = 10 / 7 * opacity - 3 / 7;
      opacitySun = 0;
    } else if (opacity <= 0.7 && opacity >= 0.3) {
      opacityDrop = 0;
      opacityCloud = 10 / 7 * opacity - 3 / 7;
      if (opacity > 0.6) {
        opacitySun = -10 * opacity + 7;
      } else {
        opacitySun = 1;
      }
      // opacitySun = -10 / 7 * opacity + 1;
    } else if (opacity < 0.3) {
      opacityCloud = 0;
      opacityDrop = 0;
      opacitySun = 1;
      // opacitySun = -10 / 7 * opacity + 1;
    }

    var sw = size.width;
    var sh = size.height;
    var paint = Paint();

    /// Paint Sun
    Path sunWave = Path();
    sunWave.addOval(
        Rect.fromCircle(center: Offset(sw * 0.5, sh * 0.45), radius: 25));
    sunWave.close();
    paint.color = Colors.yellow.shade800.withOpacity(opacitySun!);
    canvas.drawPath(sunWave, paint);

    /// Paint Cloud
    Path cloudWave = Path();
    cloudWave.moveTo(sw * 0.45, sh * 0.49);
    cloudWave.arcToPoint(Offset(sw * 0.45, sh * 0.45),
        radius: const Radius.circular(10));
    cloudWave.arcToPoint(Offset(sw * 0.60, sh * 0.49),
        radius: const Radius.circular(35));
    cloudWave.close();
    paint.color = Colors.black.withOpacity(opacityCloud!);
    canvas.drawPath(cloudWave, paint);

    ///Paint drop
    var outline = Paint()
      ..color = Colors.blue.withOpacity(opacityDrop!)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    canvas.drawLine(
        Offset(sw * 0.46, sh * 0.5), Offset(sw * 0.45, sh * 0.51), outline);
    canvas.drawLine(
        Offset(sw * 0.51, sh * 0.5), Offset(sw * 0.49, sh * 0.51), outline);
    canvas.drawLine(
        Offset(sw * 0.565, sh * 0.5), Offset(sw * 0.55, sh * 0.513), outline);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
