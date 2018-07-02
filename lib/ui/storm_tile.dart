import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/util/DateUtil.dart';
import 'package:stormtr/views/storm_record_view.dart';

class StormTile extends StatefulWidget {
  final Storm storm;
  final VoidCallback onDismiss;
  final VoidCallback onSave;

  // constructor
  StormTile(
      {@required this.storm, @required this.onDismiss, @required this.onSave});

  @override
  StormTileState createState() {
    return new StormTileState();
  }
}

class StormTileState extends State<StormTile> {
  final GlobalKey<StormTileState> _tileKey = new GlobalKey<StormTileState>();

  @override
  Widget build(BuildContext context) {
    int stormId = widget.storm.id;

    return new InkWell(
      key: _tileKey,
      onTap: () async {
        Storm result =
            await appUtil.gotoPage(context, new StormRecordView(stormId), true);

        if (result != null) {
          widget.onSave();
        }
      },
      child: new Dismissible(
        key: new Key(stormId.toString()),
        background: new Material(
          color: Colors.red.shade300,
          child: new Icon(
            Icons.delete_sweep,
            size: 40.0,
          ),
        ),
        onDismissed: (dir) {
          print("Dismissed to : " + dir.toString());
          widget.onDismiss();
        },
        child: _buildListTile(widget.storm),
      ),
    );
  }

  Widget _buildListTile(Storm storm) {
    return Material(
        elevation: 10.0,
        child: ListTile(
          title: new Wrap(
            children: [
              _buildDateRange(storm.startDatetime, storm.endDatetime),
              new Column(children: [
                _buildLevelIconDisplay(Icons.flash_on, storm.intensity),
                _buildLevelIconDisplay(Icons.cloud, storm.flux),
              ]),
              _buildNoteText(storm.notes),
            ],
          ),
        ));
  }

  Widget _buildDateRange(DateTime startDate, DateTime endDate) {
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
        style: TextStyle(fontWeight: FontWeight.bold),
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

  Widget _buildNoteText(String notes) {
    if (notes == null || notes == "") {
      return new SizedBox(
        width: 0.0,
        height: 0.0,
      );
    }

    return IconButton(
      onPressed: () {
        showDialog(
            builder: (BuildContext context) {
              return new Dialog(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(notes),
                ),
              );
            },
            context: _tileKey.currentContext);
      },
      icon: Icon(Icons.text_fields),
    );
  }

  Widget _buildLevelIconDisplay(IconData icon, int value) {
    int level = value != null ? value : 0;

    List<Widget> list = new List<Widget>();
    for (int i = 1; i <= 5; i++) {
      list.add(new Icon(
        icon,
        size: 17.0,
        color: i <= level ? Colors.red : Colors.grey.shade300,
      ));
    }

    return new Card(
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Wrap(children: list),
      ),
    );
  }
}
