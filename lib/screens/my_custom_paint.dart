import 'dart:math';

import 'package:flutter/material.dart';

import '../constant/color.dart';

class MyCustomPainter extends CustomPainter {
  double percentage;
  MyCustomPainter(this.percentage);

  double radius = 110.0;
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2 + 150);
    Rect rect =
        Rect.fromCenter(center: center, width: radius * 2, height: radius * 2);
    var startAngle = -90 * pi / 180;
    var sweepAngle = 360 * (percentage / 100) * pi / 180;

    drawCircle(canvas, center, radius);
    drawArc(canvas, rect, center, startAngle, sweepAngle);
    drawLittleCircle(center, radius, startAngle, sweepAngle, canvas);
    drawBorderCircle(center, radius, startAngle, sweepAngle, canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  void drawCircle(Canvas canvas, Offset center, double radius) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..color = lightGreenColor;

    canvas.drawCircle(center, radius, paint);
  }

  void drawArc(Canvas canvas, Rect rect, Offset center, double startAngle,
      double sweepAngle) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        transform: GradientRotation((360 * (percentage / 100) * pi / 170)),
        colors: [greenColor.withOpacity(1.0), whiteColor.withOpacity(0.0)],
      ).createShader(rect)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  void drawLittleCircle(Offset center, double radius, double startAngle,
      double sweepAngle, Canvas canvas) {
    double dx = center.dx + radius * cos(startAngle + sweepAngle);
    double dy = center.dy + radius * sin(startAngle + sweepAngle);
    final Offset progressPoint = Offset(dx, dy);
    Paint pointPaint = Paint()
      ..color = greenColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(progressPoint, 11, pointPaint);
  }

  void drawBorderCircle(Offset center, double radius, double startAngle,
      double sweepAngle, Canvas canvas) {
    double dx = center.dx + radius * cos(startAngle + sweepAngle);
    double dy = center.dy + radius * sin(startAngle + sweepAngle);
    final Offset progressPoint = Offset(dx, dy);
    Paint pointPaint = Paint()
      ..color = whiteColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(progressPoint, 11, pointPaint);
  }
}
