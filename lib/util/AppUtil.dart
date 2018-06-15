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
}

AppUtil appUtil = new AppUtil();
