import 'package:flutter/material.dart';
import 'package:stormtr/ui/logo.dart';
import 'package:stormtr/views/navigation/app_navigator_view.dart';
import 'package:stormtr/views/navigation/navigatable.dart';

class AppDrawer extends StatefulWidget {
  final AppNavigatorViewState _navigatorViewState;
  AppDrawer(this._navigatorViewState);

  @override
  State<StatefulWidget> createState() {
    return new AppDrawerState();
  }
}

class AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      DrawerHeader(
        child: new Logo(25.0, MainAxisAlignment.center),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
        ),
      ),
    ];

    for (Navigatable view in widget._navigatorViewState.views) {
      _list.add(
        ListTile(
          selected: view == widget._navigatorViewState.currentView,
          trailing: Icon(view.icon),
          title: Text(view.title),
          onTap: () {
            Navigator.of(context).pop();
            widget._navigatorViewState.navigateTo(view);
          },
        ),
      );
    }

    _list.add(Divider());
    _list.add(
      ListTile(
        trailing: Icon(Icons.close),
        title: Text("Close"),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );

    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: _list,
      ),
    );
  }
}
