import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DrawHorizontalLine extends CustomPainter {
  Paint _paint;

  DrawHorizontalLine(Color color) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-20.0, 0.0), Offset(20.0, 0.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class TabHighLightLine extends CustomPainter {
  Paint _paint;

  TabHighLightLine(Color color, bool expand) {
    _paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawLine(Offset(-45.0, 8.0), Offset(8.0, 8.0), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
