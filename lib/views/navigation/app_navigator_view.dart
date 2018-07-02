import 'package:flutter/material.dart';

import 'package:stormtr/views/navigation/appdrawer_view.dart';
import 'package:stormtr/views/navigation/navigatable.dart';

import 'package:stormtr/views/home_view.dart';
import 'package:stormtr/views/charts_view.dart';
import 'package:stormtr/views/timeline_view.dart';

class AppNavigatorView extends StatefulWidget {
  @override
  AppNavigatorViewState createState() => AppNavigatorViewState();
}

class AppNavigatorViewState extends State<AppNavigatorView> {
  List<Navigatable> _views;
  Navigatable _currentView;

  List<Navigatable> get views => _views;
  Navigatable get currentView => this._currentView;

  @override
  void initState() {
    /* List of views that can be loaded in home view */
    _views = [
      Navigatable(
        icon: Icons.home,
        title: "Home",
        builder: () => HomeView(),
      ),
      Navigatable(
        icon: Icons.timeline,
        title: "Time Line",
        builder: () => TimelineView(),
      ),
      Navigatable(
        icon: Icons.pie_chart,
        title: "Charts",
        builder: () => ChartsView(),
      ),
    ];

    /* Set timeline view as the default view */
    _currentView = _views[1];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(_currentView != null ? _currentView.title : null),
      ),
      body: _currentView.builder(),
      drawer: AppDrawer(this),
    );
  }

  void navigateTo(Navigatable view) {
    setState(() {
      _currentView = view;
    });
  }
}
