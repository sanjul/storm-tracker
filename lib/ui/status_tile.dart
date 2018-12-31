import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/util/DateUtil.dart';
import 'package:stormtr/views/storm_record_view.dart';

class StatusTile extends StatefulWidget {
  final Storm storm;
  final VoidCallback onSave;
  final VoidCallback onStopStorm;

  // constructor
  StatusTile(
      {@required this.storm, this.onSave, this.onStopStorm});

  @override
  State<StatefulWidget> createState() {
    return new StatusTileState();
  }
}

class StatusTileState extends State<StatusTile> {
  final GlobalKey<StatusTileState> _tileKey = new GlobalKey<StatusTileState>();

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
      child: _buildListTile(widget.storm)
    );
  }

  Widget _buildListTile(Storm storm) {
    return ListTile(
      title: new Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          _buildDateRange(storm.startDatetime, storm.endDatetime),
        ],
      ),
      trailing: (widget.onStopStorm != null && storm.endDatetime == null)
          ? InkWell(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.stop, color: Colors.red,),
                  Text('Stop'),
                ],
              ),
              onTap: () {
                StormsData _stormsData = new Injector().stormsData;
                storm.endDatetime = DateTime.now();
                _stormsData.saveStormRecord(storm.id, storm)
                  .then((stormId) => widget.onSave())
                  .then((stormId) => widget.onStopStorm());
              },
            )
          : null,
    );
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
      bubbleColor = Colors.blue;// Colors.primaries[color];
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

}
