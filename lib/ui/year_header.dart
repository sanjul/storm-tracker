import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/util/DateUtil.dart';

class YearHeader extends StatefulWidget {
  final String _year;
  String get year => _year;
  YearHeader(Storm storm)
      : _year = dateUtil.getYear(storm.startDatetime ?? storm.endDatetime);

  @override
  YearHeaderState createState() {
    return new YearHeaderState();
  }
}

class YearHeaderState extends State<YearHeader> {
  @override
  Widget build(BuildContext context) {
    String year = widget.year;

    return RotatedBox(
      quarterTurns: 4,
      child: new Padding(
        padding: new EdgeInsetsDirectional.only(start: 4,top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.adjust,
              color: Theme.of(context).accentColor,
            ),
            Card(
              margin: EdgeInsets.all(0),              
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  bottomRight: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
              ),
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                  start: 10,
                  end: 4,
                ),
                child: Text(
                  year,
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
