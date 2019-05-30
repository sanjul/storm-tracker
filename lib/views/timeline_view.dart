import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/state/TimelineState.dart';
import 'package:stormtr/ui/storm_tile.dart';
import 'package:stormtr/ui/year_header.dart';
import 'package:stormtr/views/storm_record_view.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/util/DateUtil.dart';

class TimelineView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimelineViewState();
  }

    static ChangeNotifierProvider buildWithState() {
    return ChangeNotifierProvider<TimelineState>(
      builder: (_) {
        TimelineState state = TimelineState();
        state.loadStormsList();
        return state;       
      } ,
      child: TimelineView()
    );
  }
}

class TimelineViewState extends State<TimelineView>{
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _loadFailed;
  TimelineState _timelineState;
  
  @override
  Widget build(BuildContext context) {

    _timelineState 
      = Provider.of<TimelineState>(context);

    return new Scaffold(
      key: _scaffoldKey,
      body: _buildStormsListBody(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          Storm result =
              await appUtil.gotoPage(context, new StormRecordView(null), true);
          if (result != null) {
            _timelineState.loadStormsList();
          }
        },
        tooltip: 'Record a Storm',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _buildStormsListBody() {
    if (_loadFailed == true) {
      return new Center(child: new Text("Load failed"));
    }

    if (_timelineState.stormsList == null) {
      return new Center(child: CircularProgressIndicator());
    }

    if (_timelineState.stormsList.isEmpty) {
      return welcomeNote();
    }

    return Stack(
      children: [
        _buildVerticalLine(),
        _buildTimeLine(),
      ],
    );
  }


  Widget _buildVerticalLine() {
    return Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 14.0,
      child: Opacity(
        opacity: 0.5,
        child: new Container(
          height: double.infinity,
          width: 4,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget _buildTimeLine() {
    return SideHeaderListView(
      itemCount: _timelineState.stormsList.length,
      itemExtend: 100.0,
      headerBuilder: (BuildContext context, int index) {
        return YearHeader(_timelineState.stormsList[index]);
      },
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            StormTile(
              storm: _timelineState.stormsList[index],
              onDismiss: () => onStormDismissCallBack(_timelineState.stormsList[index]),
              onSave: () => _timelineState.loadStormsList(),
            ),
          ],
        );
      },
      hasSameHeader: (int a, int b) {
        return _timelineState.stormsList[a].startDatetime.year ==
            _timelineState.stormsList[b].startDatetime.year;
      },
    );
  }

  Future onStormDismissCallBack(Storm storm) async {
    await _timelineState.deleteStorm(storm);
    _timelineState.loadStormsList();
    onStormDeleteComplete(storm);
  }

  void onStormDeleteComplete(Storm storm) {
    String dispDate = dateUtil.formatDate(storm.startDatetime);
    appUtil.showSnackBar(
        _scaffoldKey.currentState, "Record of $dispDate deleted!", "Undo", () {
      _timelineState
          .undoStormDelete(storm)
          .then((storm) => onStormDeleteUndoComplete(storm));
    });
  }

  void onStormDeleteUndoComplete(Storm storm) {
    String dispDate = dateUtil.formatDate(storm.startDatetime);
    appUtil.showSnackBar(
        _scaffoldKey.currentState, "Record of $dispDate restored!");
    setState(() {});
  }

  Widget welcomeNote() {
    return Center(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(
              Icons.filter_vintage,
              color: Colors.purpleAccent,
              size: 80.0,
            ),
            new Text("Welcome!", textScaleFactor: 2.5),
            SizedBox(
              height: 30.0,
            ),
            new Text(
              "Tap the + button to add a new record",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
