import 'package:flutter/material.dart';
import '/consts/colors.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = kYellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.1748167, size.height * 0.7711333,
        size.width * 0.4983667, size.height * 0.7514667);
    path0.quadraticBezierTo(size.width * 0.8310167, size.height * 0.7406000,
        size.width * 0.9988833, 0);
    path0.lineTo(0, 0);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
