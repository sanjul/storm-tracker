import 'package:flutter/material.dart';
import 'package:stormtr/data/home_data.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/modules/home_presenter.dart';
import 'package:stormtr/ui/WelcomeNote.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:stormtr/ui/status_tile.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeViewContract {
  HomeData _homeData;
  String _moodAnimation = "sunnyday";
  FlareController animController;

  HomePresenter _presenter;
  _HomeViewState() {
    _presenter = new HomePresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadHome();
  }

  @override
  void onError(error) {
    print(error);
  }

  @override
  void onLoadComplete(HomeData home) {
    _homeData = home;
    _updateAnimation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_homeData != null) {
      return Scaffold(
        floatingActionButton: floatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _homeData.isNotEmpty
            ? homeBody()
            : WelcomeNote("Tap the record button when a storm begins"),
      );
    } else {
      return showProgress();
    }
  }

  Widget homeBody() {
    List<Widget> _items = List<Widget>();
    _items.add(showLastStorm());

    if (_homeData.stats.isNotEmpty)
      _items.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Icon(
            Icons.wb_incandescent,
            color: Theme.of(context).accentColor,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            "Insights",
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Theme.of(context).accentColor,
            ),
          ),
        ]),
      ));

    _homeData.stats.forEach((stat) {
      _items.add(
        Opacity(
          opacity: 0.8,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(stat),
            ),
          ),
        ),
      );
    });

    return Container(
      padding: EdgeInsets.all(20),
      child: Stack(
        children: [
          _getMoodAnimation(),
          ListView(
            children: _items,
          ),
        ],
      ),
    );
  }

  Widget showLastStorm() {
    Widget _caption;
    if (_homeData.lastStorm.endDateDB == null) {
      _caption = _stormCaption(Icons.update, "In progress:");
    } else {
      _caption = _stormCaption(Icons.event_available, "Completed:");
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _caption,
        SizedBox(height: 8.0),
        StatusTile(
          storm: _homeData.lastStorm,
          onSave: () => _presenter.loadHome(),
          onStopStorm: () {
            _updateAnimation();
          },
        ),
      ],
    );
  }

  Widget _getMoodAnimation() {
    return Opacity(
        opacity: 0.5,
          child: FlareActor(
        'assets/animations/sunandstorm.flr',
        fit: BoxFit.contain,
        alignment: Alignment.center,
        animation: _moodAnimation,
        controller: animController,
        callback: (a) {
          if (a == "stormyday_ends") {
            _moodAnimation = "sunnyday";
          } else if (a == "sunnyday_ends") {
            _moodAnimation = "stormyday";
          }
          setState(() {});
        },
      ),
    );
  }

  void _updateAnimation() {
    String animationName = "sunnyday";
    if (_homeData != null) {
      if (_homeData.isStormInProgress) {
        animationName = "sunnyday_ends";
      } else {
        animationName = "stormyday_ends";
      }
    }

    setState(() {
      _moodAnimation = animationName;
      print("animation = $_moodAnimation");
    });
  }

  Widget floatingButton() {
    if (_homeData.lastStorm != null &&
        _homeData.lastStorm.endDatetime == null) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () {
        Storm storm = Storm();
        storm.startDatetime = DateTime.now();
        StormsData _stormsData = new Injector().stormsData;
        _stormsData
            .saveStormRecord(null, storm)
            .then((stormId) => _presenter.loadHome())
            .then((stormId) => _updateAnimation());
      },
      tooltip: 'Start recording storm',
      child: new Icon(Icons.fiber_manual_record),
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _stormCaption(IconData icon, String caption) {
    return Row(children: [
      Icon(
        icon,
        color: Theme.of(context).accentColor,
        size: 30.0,
      ),
      SizedBox(
        width: 10.0,
      ),
      Text(
        caption,
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
    ]);
  }

  // Widget _glowingContainer({Widget child}) {
  //   return Container(
  //     child: child,
  //     decoration: BoxDecoration(
  //       boxShadow: [
  //         BoxShadow(color: Colors.black, blurRadius: 30.0, spreadRadius: 10.0),
  //       ],
  //     ),
  //   );
  // }
}
