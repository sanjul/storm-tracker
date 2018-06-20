import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/util/DateUtil.dart';

class YearHeader extends StatefulWidget {
  String _year;
  String get year => _year;
  YearHeader(Storm storm) {
    DateTime date;
    if (storm != null) {
      date = storm.startDatetime ?? storm.endDatetime;
    }
    _year = dateUtil.getYear(date);
  }

  @override
  YearHeaderState createState() {
    return new YearHeaderState();
  }
}

class YearHeaderState extends State<YearHeader> {
  @override
  Widget build(BuildContext context) {
    String year = widget.year;

    return new RotatedBox(
      quarterTurns: 3,
      child: new Padding(
        padding: new EdgeInsetsDirectional.only(end: 10.0),
        child: new Row(
          children: [
            new Icon(Icons.timeline),
            new Card(
              child: new Padding(
                padding: new EdgeInsets.all(2.0),
                child: Text(
                  year,
                  textScaleFactor: 1.2,
                ),
              ),
            ),
            new Icon(Icons.blur_on),
          ],
        ),
      ),
    );
  }
}
