import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Square

    Paint paintFill1 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;
    paintFill1.shader = ui.Gradient.linear(
        Offset(size.width * 0.50, size.height * -0.51),
        Offset(size.width * 1.00, size.height * 1.22),
        [const Color(0xff05115b), const Color(0xffffffff)],
        [0.00, 1.00]);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.0012542, size.height * -0.0904255);
    path_1.cubicTo(
        size.width * 0.2854924,
        size.height * 0.3803548,
        size.width * 0.5601486,
        size.height * -0.5145128,
        size.width * 0.9977121,
        size.height * -0.0990015);
    path_1.quadraticBezierTo(size.width * 0.9977121, size.height * 0.2300120,
        size.width * 0.9977121, size.height * 1.2170056);
    path_1.lineTo(size.width * 0.0000000, size.height * 1.2170056);
    path_1.quadraticBezierTo(size.width * 0.0012542, size.height * 0.8585175,
        size.width * 0.0012542, size.height * -0.0904255);
    path_1.close();

    canvas.drawPath(path_1, paintFill1);

    // Square

    Paint paintStroke1 = Paint()
      ..color = const Color.fromARGB(17, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.00
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(path_1, paintStroke1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
