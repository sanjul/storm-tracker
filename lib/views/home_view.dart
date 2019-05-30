import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/state/HomeState.dart';
import 'package:stormtr/ui/WelcomeNote.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:stormtr/ui/insights.dart';
import 'package:stormtr/ui/status_tile.dart';

class HomeView extends StatefulWidget {
  @override
  HomeViewState createState() => HomeViewState();

  static ChangeNotifierProvider buildWithState() {
    return ChangeNotifierProvider<HomeState>(
      builder: (_) {
        HomeState state = HomeState();
        state.loadHome();
        return state;       
      } ,
      child: HomeView()
    );
  }
}

class HomeViewState extends State<HomeView> {
  String _moodAnimation = "sunnyday";
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
        floatingActionButton: floatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _homeState.homeData.isNotEmpty
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
    _items.add(Insights(data: _homeState.homeData));

    return Container(
      padding: EdgeInsets.all(0),
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
    if (_homeState.homeData.lastStorm.endDateDB == null) {
      _caption = _stormCaption(Icons.update, "In progress:");
    } else {
      _caption = _stormCaption(Icons.event_available, "Completed:");
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _caption,
          SizedBox(height: 8.0),
          StatusTile(
            storm: _homeState.homeData.lastStorm,
            onSave: () => _homeState.loadHome(),
            onStopStorm: () {
              _updateAnimation();
            },
          ),
        ],
      ),
    );
  }

  Widget _getMoodAnimation() {
    return Opacity(
      opacity: 0.5,
      child: FlareActor(
        'assets/animations/sunandstorm.flr',
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
        animation: _moodAnimation,
        callback: (a) {
          if (a == "stormyday_ends") {
            _moodAnimation = "sunnyday";
          } else if (a == "sunnyday_ends") {
            _moodAnimation = "stormyday";
          }
        },
      ),
    );
  }

  void _updateAnimation() {
    String animationName = "sunnyday";
    if (_homeState.homeData != null) {
      if (_homeState.homeData.isStormInProgress) {
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
    if (_homeState.homeData.lastStorm != null &&
        _homeState.homeData.lastStorm.endDatetime == null) {
      return null;
    }

    return FloatingActionButton(
      onPressed: () {
        Storm storm = Storm();
        storm.startDatetime = DateTime.now();
        StormsData _stormsData = new Injector().stormsData;
        _stormsData
            .saveStormRecord(null, storm)
            .then((stormId) => _homeState.loadHome())
            .then((stormId) => _updateAnimation());
      },
      highlightElevation: 10,
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
}
