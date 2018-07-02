import 'package:flutter/material.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/modules/storms_list_presenter.dart';
import 'package:stormtr/ui/storm_tile.dart';
import 'package:stormtr/ui/year_header.dart';
import 'package:stormtr/views/storm_record_view.dart';
import 'package:stormtr/util/AppUtil.dart';


class TimelineView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new TimelineViewState();
  }
}

class TimelineViewState extends State<TimelineView> implements StormsListViewContract {
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
        onPressed: () {
          appUtil.gotoPage(context, new StormRecordView(null), true);
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
      return Center(
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.flag),
              new Text("Let's start fresh!", textScaleFactor: 2.5),
              new Text("Tap on the + icon to add a new record"),
            ],
          ),
        ),
      );
    }

    return new SideHeaderListView(
      itemCount: _stormsList.length,
      itemExtend: 100.0,
      headerBuilder: (BuildContext context, int index) {
        return new YearHeader(_stormsList[index]);
      },
      itemBuilder: (BuildContext context, int index) {
        return new Card(
            child: StormTile(
          _stormsList[index],
          () => onStormDismissCallBack(_stormsList[index]),
        ));
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
    appUtil.showSnackBar(
        _scaffoldKey.currentState, "Storm record deleted!", "Undo", () {
      _presenter
          .undoStormDelete(storm)
          .then((a) => _presenter.loadStormsList());
    });
  }

  @override
  void onStormDeleteUndoComplete(Storm storm, int newStormId) {
    appUtil.showSnackBar(_scaffoldKey.currentState, "Storm record restored!");
    setState(() {});
  }
}
