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
      Navigatable(icon: Icons.home, title: "Home",
          // builder: () =>  HomeView(),
          views: [
            Navigatable(
              title: "Home",
              icon: Icons.home,
              builder: () => HomeView(),
            ),
            Navigatable(
              title: "Time Line",
              icon: Icons.timeline,
              builder: () => TimelineView(),
            )
          ]),
      Navigatable(
        icon: Icons.pie_chart,
        title: "Charts",
        builder: () => ChartsView(),
      ),
    ];

    /* Set Home view as the default view */
    _currentView = _views[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Scaffold(
      appBar: new AppBar(
        title: Text(_currentView != null ? _currentView.title : null),
        bottom: _buildTabs(),
      ),
      body: _buildBody(),
      drawer: AppDrawer(this),
    );

    if (_currentView.builder == null &&
        _currentView.views != null &&
        _currentView.views.isNotEmpty) {
      content = DefaultTabController(
        length: _currentView.views.length,
        child: content,
      );
    }

    return content;
  }

  void navigateTo(Navigatable view) {
    setState(() {
      _currentView = view;
    });
  }

  Widget _buildBody() {
    if (_currentView.builder != null) {
      return _currentView.builder();
    } else if (_currentView.views != null && _currentView.views.isNotEmpty) {
      return TabBarView(
        children: _currentView.views
            .map(
              (nav) => nav.builder(),
            )
            .toList(),
      );
    } else {
      return Center(child: Text("Invalid view"));
    }
  }

  Widget _buildTabs() {
    if (_currentView.views != null && _currentView.builder == null) {
      List<Tab> _tabs = new List<Tab>();
      _currentView.views.forEach((nav) {
        _tabs.add(Tab(
          icon: Icon(nav.icon),
          text: nav.title,
        ));
      });
      return TabBar(
        tabs: _tabs,
      );
    }

    return null;
  }
}
