import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/modules/home_presenter.dart';
import 'package:stormtr/ui/storm_tile.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeViewContract {
  List<Storm> _stormsList;
  Storm _lastStorm;
  bool isLoaded;
  double avgDuration;

  HomePresenter _presenter;
  _HomeViewState() {
    isLoaded = false;
    avgDuration = 0.0;
    _presenter = new HomePresenter(this);
  }

  @override
  void initState() {
    _presenter.loadHome();
    super.initState();
  }

  @override
  void onError(error) {
    // TODO: implement onError
  }

  @override
  void onLoadComplete(List<Storm> stormsList) {
    isLoaded = true;
    _stormsList = stormsList;
    _stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));
    _lastStorm =
        _stormsList != null && _stormsList.isNotEmpty ? _stormsList[0] : null;

    int totalDays = 0;
    int count = 0;
    for (Storm storm in _stormsList) {
      if (storm.startDatetime != null && storm.endDatetime != null) {
        int daysDiff = storm.endDatetime.difference(storm.startDatetime).inDays;
        totalDays += daysDiff;
        count++;
      }
      avgDuration = totalDays / count;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded ? _buildBody() : CircularProgressIndicator();
  }

  Widget _buildBody() {
    if (_stormsList.isEmpty) {
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

    return ListView(
      children: <Widget>[
        DrawerHeader(
          child: Column(
            children: <Widget>[
              Text("Storm in progress:"),
              SizedBox(height: 8.0),
              StormTile(
                storm: _lastStorm,
                onSave: () => _presenter.loadHome(),
                onStopStorm: () => _presenter.loadHome(),
              ),
              SizedBox(height: 8.0),
              Text("Average duration : ${avgDuration.toInt()} days")
            ],
          ),
        )
      ],
    );
  }
}
