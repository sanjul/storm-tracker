import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/AppState.dart';
import 'package:stormtr/ui/config/Config.dart';
import 'package:stormtr/ui/navigation/navigatable.dart';

class AppBackdrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    Navigatable _currentView = appState.currentView;

    List<Widget> _list = [];

    for (Navigatable view in Config.navigatables) {
      _list.add(
        ListTile(
          selected: view.title == _currentView.title,
          trailing: Icon(view.icon),
          title: Text(view.title),
          onTap: () {
            appState.navigateToView(view);
            appState.toggleBackdrop();
          },
        ),
      );
    }

    _list.add(Divider());
    _list.add(ListTile(
        title: Text("Dark Theme"),
        trailing: Switch(
          onChanged: (bool val) {
            Provider.of<AppState>(context).setDarkModeEnabled(val);
          },
          value: Provider.of<AppState>(context).isDarkModeEnabled,
        )));

    return Container(
      color: Theme.of(context).backgroundColor,
      child: ListView(
        // Important: Remove any padding from the ListView.
        // padding: EdgeInsets.zero,
        children: _list,
      ),
    );
  }
}
