import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stormtr/util/DateUtil.dart';

class DateRangeBubbles extends StatelessWidget {
  BuildContext _context;
  final DateTime startDate;
  final DateTime endDate;

  //constructor
  DateRangeBubbles({@required this.startDate, @required this.endDate});

  @override
  Widget build(BuildContext context) {
    _context = context;
    int _random = new Random().nextInt(Colors.primaries.length);
    return new Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildDateBubble(startDate, _random),
        new Icon(Icons.chevron_right),
        _buildDateBubble(endDate, _random),
      ],
    );
  }

  Widget _buildDateBubble(DateTime date, int color) {
    Color bubbleColor;
    Widget bubbleChild;
    String month;
    double spaceHeight;

    if (date == null) {
      bubbleColor = Colors.grey.shade300;
      bubbleChild = new Icon(Icons.help);
      month = "";
      spaceHeight = 0.0;
    } else {
      bubbleColor = Colors.primaries[color];
      bubbleChild = Text(
        dateUtil.getDay(date),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
      month = dateUtil.formatToMonth(date);
      spaceHeight = 4.0;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: bubbleColor,
            radius: 20.0,
            child: bubbleChild,
          ),
          SizedBox(
            height: spaceHeight,
          ),
          Text(
            month,
          )
        ],
      ),
    );
  }
}