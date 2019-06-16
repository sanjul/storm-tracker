

import 'package:flutter/widgets.dart';

class CoverClipper extends CustomClipper<Path>{
  final double curveOffset;
  final double heightOffset;

  CoverClipper(this.heightOffset, this.curveOffset);


  @override
  getClip(Size size) {

    double maxHeight = size.height - heightOffset.abs();

    Path path = new Path();
    path.lineTo(0.0, maxHeight);
    path.cubicTo(size.width/4, maxHeight + curveOffset, (size.width/4)*3, maxHeight - curveOffset, size.width, maxHeight);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;

}