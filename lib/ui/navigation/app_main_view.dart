import 'dart:ui';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/AppState.dart';
import 'package:stormtr/ui/navigation/app_backdrop.dart';
import 'package:stormtr/ui/navigation/app_front_nav_view.dart';

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
        _buildFrontView(context),
      ]),
    );
  }

  Widget _buildFrontView(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    Size size = MediaQuery.of(context).size;

    return Animator(
      tweenMap: {
        "pos": appState.getBackdropToggleTween(0, size.height / 2),
      },
      curve: Curves.easeOutCirc,
      cycles: 1,
      duration: Duration(seconds: 1),
      builderMap: (Map<String, Animation> anim) => Positioned.fromRelativeRect(
            rect: RelativeRect.fromLTRB(0, anim['pos'].value, 0, 0),
            child: PhysicalShape(
              elevation: 12.0,
              color: Theme.of(context).canvasColor,
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    // topLeft: Radius.circular(40),
                  ),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: _buildBlur(
                AppFrontNavView(),
                appState.isBackdropVisible,
              ),
            ),
          ),
    );
  }

  Widget _buildBlur(Widget child, bool isBlured) {
    if (!isBlured) {
      return child;
    }

    return Stack(
      children: <Widget>[
        AbsorbPointer(child: child),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
        )
      ],
    );
  }
}
