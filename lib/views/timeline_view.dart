import 'package:flutter/material.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/modules/storms_list_presenter.dart';
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
}

class TimelineViewState extends State<TimelineView>
    implements StormsListViewContract {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  StormsListPresenter _presenter;
  List<Storm> _stormsList;
  bool _loadFailed;

  //constructor
  TimelineViewState() {
    _presenter = new StormsListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadStormsList();
  }

  void onStormDismissCallBack(Storm storm) {
    _presenter.deleteStorm(storm);
    _presenter.loadStormsList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: _buildStormsListBody(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () async {
          Storm result =
              await appUtil.gotoPage(context, new StormRecordView(null), true);
          if (result != null) {
            _presenter.loadStormsList();
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

    if (_stormsList == null) {
      return new Center(child: CircularProgressIndicator());
    }

    if (_stormsList.isEmpty) {
      return welcomeNote();
    }

    return Stack(
      children: [
        new Positioned(
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
        ),
        _buildTimeLine(),
      ],
    );
  }

  Widget _buildTimeLine() {
    return SideHeaderListView(
      itemCount: _stormsList.length,
      itemExtend: 100.0,
      headerBuilder: (BuildContext context, int index) {
        return YearHeader(_stormsList[index]);
      },
      itemBuilder: (BuildContext context, int index) {
        return Stack(
          children: [
            StormTile(
              storm: _stormsList[index],
              onDismiss: () => onStormDismissCallBack(_stormsList[index]),
              onSave: () => _presenter.loadStormsList(),
            ),
          ],
        );
      },
      hasSameHeader: (int a, int b) {
        return _stormsList[a].startDatetime.year ==
            _stormsList[b].startDatetime.year;
      },
    );
  }

  @override
  void onLoadStormsListComplete(List<Storm> stormsList) {
    setState(() {
      _stormsList = stormsList;
      _stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));
      _loadFailed = false;
    });
  }

  @override
  void onError(dynamic err) {
    _loadFailed = true;
    print("Error occured: " + err.toString());
    // TODO: implement onLoadStormsListError
  }

  @override
  void onStormDeleteComplete(bool isDeleted, Storm storm) {
    String dispDate = dateUtil.formatDate(storm.startDatetime);
    appUtil.showSnackBar(
        _scaffoldKey.currentState, "Record of $dispDate deleted!", "Undo", () {
      _presenter
          .undoStormDelete(storm)
          .then((a) => _presenter.loadStormsList());
    });
  }

  @override
  void onStormDeleteUndoComplete(Storm storm, int newStormId) {
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
