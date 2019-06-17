import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/HomeState.dart';

enum RecContrlBtnType { StormStart, StormEnd }

class RecordControllButton extends StatelessWidget {
  final RecContrlBtnType type;

  RecordControllButton(this.type);

  @override
  Widget build(BuildContext context) {
    HomeState _homeState = Provider.of<HomeState>(context);

    // Return no Button on invalid state
    if (_homeState != null) {
      if ((type == RecContrlBtnType.StormEnd &&
              _homeState.mood == Mood.SUNNY_DAY) ||
          (type == RecContrlBtnType.StormStart &&
              _homeState.mood == Mood.STORMY_DAY)) {
        return Container();
      }
    }

    return floatingButton(context);
  }

  Widget floatingButton(BuildContext context) {
    HomeState _homeState = Provider.of<HomeState>(context);

    Widget button;
    if (_homeState.homeData.lastStorm != null &&
        _homeState.homeData.lastStorm.endDatetime == null) {
      button = FloatingActionButton.extended(
        heroTag: "recordControllerBtn",
        onPressed: _homeState.stopStormRecord,
        highlightElevation: 10,
        tooltip: 'Stop recording storm',
        icon: new Icon(Icons.stop),
        label: Text("Mark End"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      );
    } else {
      button = FloatingActionButton.extended(
        heroTag: "recordControllerBtn",
        onPressed: _homeState.startStormRecord,
        highlightElevation: 10,
        tooltip: 'Start recording storm',
        icon: Icon(Icons.fiber_manual_record),
        label: Text("Start Recording"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      );
    }

    return button;
  }
}
