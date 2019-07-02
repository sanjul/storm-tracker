import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/AppState.dart';
import 'package:stormtr/ui/navigation/app_backdrop.dart';
import 'package:stormtr/ui/navigation/app_frontpane.dart';

class AppMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          elevation: 0,
          title: Text(appState.viewTitle),
          actions: <Widget>[
            IconButton(
              tooltip: "Toggle menu",
              icon: appState.isBackdropVisible
                  ? Icon(Icons.close)
                  : Icon(Icons.menu),
              onPressed: appState.toggleBackdrop,
            ),
          ],
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: Stack(fit: StackFit.expand, children: <Widget>[
        AppBackdrop(),
        AppFrontPane(),
      ]),
    );
  }
}

