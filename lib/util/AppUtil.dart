import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  final formatter = new DateFormat('dd/MMM/yyyy');
  final monthFormatter = new DateFormat('MMM');

  String formatDate(DateTime date) {
    if (date == null) {
      return "<date>";
    }
    return formatter.format(date);
  }

  String getFormatedCurrentDate() {
    return formatter.format(new DateTime.now());
  }

  String formatToMonth(DateTime date) {
    if (date == null) {
      return "M";
    }
    return monthFormatter.format(date);
  }

  String getDay(DateTime date) {
    if (date == null) {
      return "D";
    }
    return date.day.toString();
  }

  String getYear(DateTime date) {
    if (date == null) {
      return "YYYY";
    }
    return date.year.toString();
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
