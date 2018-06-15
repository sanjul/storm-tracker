import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double _size;
  final MainAxisAlignment _align;

  Logo(this._size, this._align);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text(
          "storm",
          style: new TextStyle(
              fontSize: this._size,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: _size/6.25,
          ),
        ),
        new Text(
          "Tr",
          style: new TextStyle(
              fontSize: this._size,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
          ),
        )
      ],
      mainAxisAlignment: this._align,
    );
  }
}
