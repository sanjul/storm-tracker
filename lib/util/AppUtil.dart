import 'package:flutter/material.dart';

class AppUtil {

  dynamic gotoPage(BuildContext context, Widget target,
      [bool allowGoingBack = false]) async {

    dynamic result;    
    if (allowGoingBack) {
      result = await Navigator.of(context).push(
          new MaterialPageRoute(builder: (BuildContext context) => target));
    } else {
      result = await Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute<dynamic> (builder: (BuildContext context) => target),
          (Route route) => route == null);
    }

    return result;
  }

  void popPage(BuildContext context, [dynamic result]) {
    try {
      Navigator.pop(context, result);
    } catch(e){
      print('Failed popping page : ' + e.toString());
    }
    
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
