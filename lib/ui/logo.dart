import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double _size;
  final MainAxisAlignment _align;

  Logo(this._size, this._align);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Image(image:AssetImage("assets/icons/appIcon.png"), 
         fit: BoxFit.contain,
         width: this._size*3.5,),
         Row(
          children: <Widget>[
             Text(
              "Storm",
              style: TextStyle(
                fontSize: this._size,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: _size / 7,
              ),
            ),
            Text(
              "TR",
              style:  TextStyle(
                //fontFamily: "Carolingia",
                fontSize: this._size/1.5,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ],
          mainAxisAlignment: this._align,
        ),
      ],
    );
  }
}
