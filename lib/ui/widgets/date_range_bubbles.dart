import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stormtr/util/DateUtil.dart';

class DateRangeBubbles extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final bool isSpecial;

  //constructor
  DateRangeBubbles(
      {@required this.startDate,
      @required this.endDate,
      this.isSpecial = false});

  @override
  Widget build(BuildContext context) {
    int _random = new Random().nextInt(Colors.primaries.length);
    return new Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _buildDateBubble(startDate, _random, isSpecial),
        new Icon(Icons.chevron_right),
        _buildDateBubble(endDate, _random, isSpecial),
      ],
    );
  }

  Widget _buildDateBubble(DateTime date, int color, bool isSpecial) {
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
      bubbleColor = isSpecial ? Colors.white : Colors.primaries[color];
      bubbleChild = Text(
        dateUtil.getDay(date),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isSpecial ? Colors.black : Colors.white,
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
            style: isSpecial
                ? TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                : null,
          )
        ],
      ),
    );
  }
}
