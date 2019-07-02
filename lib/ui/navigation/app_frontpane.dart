import 'dart:ui';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/AppState.dart';
import 'package:stormtr/ui/navigation/app_front_nav_view.dart';

class AppFrontPane extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return _buildFrontView(context);
  }

  Widget _buildFrontView(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    Size size = MediaQuery.of(context).size;

    return useMemoized(
      () => Animator(
            tweenMap: {
              "pos": appState.getBackdropToggleTween(0, size.height / 2),
            },
            curve: Curves.easeOutCirc,
            cycles: 1,
            duration: Duration(seconds: 1),
            builderMap: (Map<String, Animation> anim) =>
                Positioned.fromRelativeRect(
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
          ),
      [
        appState.isBackdropVisible,
      ],
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
