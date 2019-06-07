import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/state/HomeState.dart';
import 'package:stormtr/ui/Cover.dart';
import 'package:stormtr/ui/WelcomeNote.dart';
import 'package:stormtr/ui/insights.dart';
import 'package:animator/animator.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();

  static ChangeNotifierProvider buildWithState() {
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
    bool isSunny = _homeState.mood == Mood.SUNNY_DAY;

    if (_homeState.homeData != null) {
      return Scaffold(
        // floatingActionButton: isSunny ? floatingButton() : null,
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
    _items.add(showStatusMessageAndButton(context));
    _items.add(Insights(data: _homeState.homeData));

    return Container(
      child: Stack(
        children: [
          Cover(),
          Padding(
            padding: const EdgeInsets.only(top: 110),
            child: ListView(
              children: _items,
            ),
          ),
        ],
      ),
    );
  }

  Widget showStatusMessageAndButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[floatingButton()],
          ),
          SizedBox(height: 8.0),
        ],
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
    }

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

    return Animator(
      tweenMap: {
        "opacity": Tween<double>(
          begin: 0.8,
          end: 1.0,
        ),
      },
      cycles: 0,
      duration: Duration(seconds: 2),
      builderMap: (Map<String, Animation> anim) => Opacity(
            child: button,
            opacity: anim["opacity"].value,
          ),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
