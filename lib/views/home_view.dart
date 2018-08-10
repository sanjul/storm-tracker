import 'package:flutter/material.dart';
import 'package:stormtr/data/home_data.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/modules/home_presenter.dart';
import 'package:stormtr/ui/storm_tile.dart';
import 'package:stormtr/util/AppUtil.dart';
import 'package:stormtr/views/storm_record_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeViewContract {
  Home _home;

  HomePresenter _presenter;
  _HomeViewState() {
    _presenter = new HomePresenter(this);
  }

  @override
  void initState() {
    _presenter.loadHome();
    super.initState();
  }

  @override
  void onError(error) {
    print(error);
  }

  @override
  void onLoadComplete(Home home) {
    _home = home;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _home != null ? _buildBody() : CircularProgressIndicator();
  }

  Widget _buildBody() {
    if (_home.isEmpty) {
      return welcomeNote();
    }

    if (true)
      return Scaffold(
        floatingActionButton: floatingButton(),
        body: homeBody(),
      );
  }

  Widget homeBody() {
    return ListView(
      children: <Widget>[
        showLastStorm(),
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Average duration : ${_home.averageDuration} days"),
              SizedBox(height: 8.0),
              Text("Average gap : ${_home.averageGap} days"),
            ],
          ),
        )
      ],
    );
  }

  Widget welcomeNote() {
    return Center(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.flag),
            new Text("Let's start fresh!", textScaleFactor: 2.5),
            CircleAvatar(
              child: IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showLastStorm() {
    Widget _caption;
    if (_home.lastStorm.endDateDB == null) {
      _caption = Row(children: [
        Icon(Icons.refresh),
        Text("Storm currently in progress"),
      ]);
    } else {
      _caption = Row(children: [
        Icon(Icons.event_available),
        Text("Completed storm"),
      ]);
    }

    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _caption,
          SizedBox(height: 8.0),
          StormTile(
            storm: _home.lastStorm,
            onSave: () => _presenter.loadHome(),
            onStopStorm: () => print("Hell no"),
          ),
        ],
      ),
    );
  }

  Widget floatingButton() {
    if (_home.lastStorm.endDatetime == null) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () {
        Storm storm = Storm();
        storm.startDatetime = DateTime.now();
        StormsData _stormsData = new Injector().stormsData;
        _stormsData
            .saveStormRecord(null, storm)
            .then((stormId) => _presenter.loadHome());
      },
      tooltip: 'Start recording storm',
      child: new Icon(Icons.play_arrow),
    );
  }
}
