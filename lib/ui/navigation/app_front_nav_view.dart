import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/AppState.dart';

import 'package:stormtr/ui/navigation/navigatable.dart';

class AppFrontNavView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    Navigatable _currentView = appState.currentView;
    Widget content = Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: Container(
        child: _buildTabs(context),
        // color: Theme.of(context).accentColor,
      ),
      // drawer: AppDrawer(),
    );

    if (_currentView.builder == null &&
        _currentView.tabs != null &&
        _currentView.tabs.isNotEmpty) {
      content = DefaultTabController(
        length: _currentView.tabs.length,
        child: content,
      );
    } else if (_currentView.builder != null &&
        (_currentView.tabs == null || _currentView.tabs.isEmpty)) {
      return _currentView.builder();
    }

    return content;
  }

  Widget _buildBody(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    Navigatable _currentView = appState.currentView;

    if (_currentView.builder != null) {
      return _currentView.builder();
    } else if (_currentView.tabs != null && _currentView.tabs.isNotEmpty) {
      return TabBarView(
        children: _currentView.tabs
            .map(
              (nav) => nav.builder(),
            )
            .toList(),
      );
    } else {
      return Center(child: Text("Invalid view"));
    }
  }

  Widget _buildTabs(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    Navigatable _currentView = appState.currentView;

    if (_currentView.tabs != null && _currentView.builder == null) {
      List<Tab> _tabs = new List<Tab>();
      _currentView.tabs.forEach((nav) {
        _tabs.add(Tab(
          icon: nav.icon != null ? Icon(nav.icon) : null,
          text: nav.title,
        ));
      });
      return TabBar(
        indicatorWeight: 5,
        labelColor: Theme.of(context).accentColor,
        tabs: _tabs,
      );
    }

    return null;
  }
}
