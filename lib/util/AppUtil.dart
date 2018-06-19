import 'package:flutter/material.dart';

class AppUtil {
  void gotoPage(BuildContext context, Widget target,
      [bool allowGoingBack = false]) {
    if (allowGoingBack) {
      Navigator.of(context).push(
          new MaterialPageRoute(builder: (BuildContext context) => target));
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (BuildContext context) => target),
          (Route route) => route == null);
    }
  }

  void popPage(BuildContext context) {
    Navigator.of(context).pop();
  }



  void showSnackBar(ScaffoldState state, String message) {
    state.showSnackBar(
      new SnackBar(
        content: new Card(
            child: new Padding(
          padding: EdgeInsets.all(10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Icon(Icons.info),
              new Text(
                message,
                textScaleFactor: 1.3,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

AppUtil appUtil = new AppUtil();
