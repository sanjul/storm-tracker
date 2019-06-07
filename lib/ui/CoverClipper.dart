

import 'package:flutter/widgets.dart';

class CoverClipper extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    double maxHeight = size.height - 5;

    Path path = new Path();
    path.lineTo(0.0, maxHeight - 20.0);
    path.cubicTo(200, maxHeight - 60, size.width-70, maxHeight + 10, size.width, maxHeight);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;

}