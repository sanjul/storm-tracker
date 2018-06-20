import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/util/DateUtil.dart';
import 'package:stormtr/views/storm_record_view.dart';

class StormTile extends StatefulWidget {
  final Storm _storm;
  final VoidCallback _onDismiss;

  Storm get storm => _storm;
  VoidCallback get onDismiss => _onDismiss;

  // constructor
  StormTile(this._storm, this._onDismiss);

  @override
  StormTileState createState() {
    return new StormTileState();
  }
}

class StormTileState extends State<StormTile> {
  @override
  Widget build(BuildContext context) {
    Storm storm = widget.storm;
    int stormId = storm.id;

    return new InkWell(
      onTap: () {
        appUtil.gotoPage(context, new StormRecordView(stormId), true);
      },
      child: new Dismissible(
        key: new Key(stormId.toString()),
        onDismissed:(dir){
          print("Dismissed to : " + dir.toString());
          widget.onDismiss();
        },
        child: _buildListTile(storm),
      ),
    );
  }

  Widget _buildListTile(Storm storm) {
    return new ListTile(
      leading: Container(
        width: 40.0,
        padding: new EdgeInsets.all(1.0),
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          border: new Border.all(width: 2.0),
        ),
        child: Column(
          children: <Widget>[
            Text(
              dateUtil.getDay(storm.startDatetime),
              textScaleFactor: 2.0,
            ),
            Text(dateUtil.formatToMonth(storm.startDatetime))
          ],
        ),
      ),
      title: new Row(
        children: <Widget>[
          new Text(dateUtil.formatToDayMonth(storm.startDatetime)),
          new Icon(Icons.arrow_right),
          new Text(dateUtil.formatToDayMonth(storm.endDatetime)),
        ],
      ),
      subtitle: _buildNoteText(storm.notes ?? ""),
      isThreeLine: true,
    );
  }

  Widget _buildNoteText(String notes) {
    List<Widget> rowChildren = new List<Widget>();

    // rowChildren.add(
    //   new Padding(
    //     padding: new EdgeInsets.only(right: 7.0),
    //     child: new Icon(
    //       Icons.mode_comment,
    //       size: 15.0,
    //     ),
    //   ),
    // );

    rowChildren.add(new Text(
      notes,
      maxLines: 2,
    ));

    return new Wrap(children: rowChildren);
  }
}
