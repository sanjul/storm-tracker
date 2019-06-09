import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/HomeState.dart';
import 'package:stormtr/ui/widgets/Cover.dart';
import 'package:stormtr/ui/widgets/WelcomeNote.dart';
import 'package:stormtr/ui/widgets/insights.dart';
import 'package:animator/animator.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();

  static ChangeNotifierProvider init() {
    return ChangeNotifierProvider<HomeState>(
        builder: (_) {
          HomeState state = HomeState();
          state.loadHome();
          return state;
        },
        child: HomeView());
  }
}

class HomeViewState extends State<HomeView> {
  HomeState _homeState;

  @override
  void setState(fn) {
    super.setState(fn);
    if (_homeState != null) {
      _homeState.loadHome();
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeState = Provider.of<HomeState>(context);

    if (_homeState.homeData != null) {
      return Scaffold(
        floatingActionButton:
            _homeState.homeData.isEmpty || _homeState.mood == Mood.SUNNY_DAY
                ? floatingButton()
                : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _homeState.homeData.isNotEmpty
            ? homeBody(context)
            : WelcomeNote("Tap the record button when a storm begins"),
      );
    } else {
      return showProgress();
    }
  }

  Widget homeBody(BuildContext context) {
    List<Widget> _items = List<Widget>();

    if (_homeState.mood == Mood.STORMY_DAY) {
      _items.add(buildMarkStormEndButton(context));
    }

    _items.add(Insights(data: _homeState.homeData));

    return Container(
      child: Stack(
        children: [
          Cover(),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: ListView(
              children: _items,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMarkStormEndButton(BuildContext context) {
    if (_homeState.mood == Mood.SUNNY_DAY) {
      return null;
    }

    return Animator(
      tweenMap: {"padding": _homeState.getTween(0,60)},
      cycles: 1,
      duration: Duration(seconds: 1),
      builderMap: (Map<String, Animation> anim) => Padding(
            padding: EdgeInsets.only(top: anim["padding"].value),
            child: Align(
              alignment: Alignment(-0.3, 0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[floatingButton()]),
            ),
          ),
    );
  }

  Widget floatingButton() {
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

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
