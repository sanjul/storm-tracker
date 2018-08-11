import 'package:flutter/material.dart';
import 'package:stormtr/data/home_data.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/modules/home_presenter.dart';
import 'package:stormtr/ui/storm_tile.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin
    implements HomeViewContract {
  Animation<double> _bgFadeAnimation;
  AnimationController _bgFadeAnimController;

  final _opacityTween = new Tween<double>(begin: 0.0, end: 0.8);

  HomeData _homeData;

  HomePresenter _presenter;
  _HomeViewState() {
    _presenter = new HomePresenter(this);
  }

  @override
  void dispose() {
    super.dispose();
    _bgFadeAnimController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _bgFadeAnimController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 600));
    _bgFadeAnimation = new CurvedAnimation(
        parent: _bgFadeAnimController, curve: Curves.easeIn);
    _bgFadeAnimController.addListener(() => this.setState(() {}));
    _presenter.loadHome();
    _animateImage();
  }

  @override
  void onError(error) {
    print(error);
  }

  @override
  void onLoadComplete(HomeData home) {
    _homeData = home;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_homeData != null) {
      return Scaffold(
        floatingActionButton: floatingButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: _homeData.isNotEmpty ? homeBody() : welcomeNote(),
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
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(stat),
          ),
        ),
      );
    });

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: _getMoodImage(),
            fit: BoxFit.contain,
            alignment: AlignmentDirectional.centerEnd,
            colorFilter: new ColorFilter.mode(
              Theme
                  .of(context)
                  .canvasColor
                  .withOpacity(_opacityTween.evaluate(_bgFadeAnimation)),
              BlendMode.dstATop,
            )),
      ),
      child: ListView(
        children: _items,
      ),
    );
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
            new Text(
              "Track your personal storms",
              style: TextStyle(color: Colors.purple),
            ),
            SizedBox(
              height: 30.0,
            ),
            new Text(
              "Tap record button when the storm starts",
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget showLastStorm() {
    Widget _caption;
    if (_homeData.lastStorm.endDateDB == null) {
      _caption = _stormCaption(Icons.update, "Storm currently in progress");
    } else {
      _caption = _stormCaption(Icons.event_available, "Completed storm");
    }

    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _caption,
          SizedBox(height: 8.0),
          StormTile(
            storm: _homeData.lastStorm,
            onSave: () => _presenter.loadHome(),
            onStopStorm: () {
              _animateImage();
            },
          ),
        ],
      ),
    );
  }

  void _animateImage() {
    setState(() {
      _bgFadeAnimController.reset();
      _bgFadeAnimController.forward();
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
            .then((stormId) => _animateImage());
      },
      tooltip: 'Start recording storm',
      child: new Icon(Icons.fiber_manual_record, color: Colors.red),
      backgroundColor: Colors.white,
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

  AssetImage _getMoodImage() {
    if (_homeData.isStormInProgress) {
      return AssetImage("assets/graphics/stormy_day_1.png");
    } else {
      return AssetImage("assets/graphics/sunny_day_1.png");
    }
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
