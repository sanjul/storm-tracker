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

  void showSnackBar(ScaffoldState state, String message,
      [String actionLabel, VoidCallback actionCallBack]) {
    List<Widget> _children = <Widget>[
      new Icon(Icons.info),
      new Text(
        message,
        textScaleFactor: 1.3,
      ),
    ];

    SnackBarAction _action;

    int _delay = 2;
    if (actionLabel != null && actionCallBack != null) {
      _action = new SnackBarAction(
        label: actionLabel,
        onPressed: () {
          state.hideCurrentSnackBar();
          actionCallBack();
        },
      );

      _delay = 10;
    }

    state.showSnackBar(
      new SnackBar(
        action: _action,
        duration: Duration(seconds: _delay),
        content: new Card(
            child: new Padding(
          padding: EdgeInsets.all(10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _children,
          ),
        )),
      ),
    );
  }
}

AppUtil appUtil = new AppUtil();
