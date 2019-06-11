import 'package:flutter/material.dart';
import 'package:stormtr/ui/widgets/logo.dart';
import 'package:stormtr/ui/config/Config.dart';
import 'package:stormtr/ui/navigation/app_navigator_view.dart';
import 'package:stormtr/util/AppUtil.dart';



class LandingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return  LandingViewState();
  }
}

class LandingViewState extends State<LandingView>
    with SingleTickerProviderStateMixin {
  Animation<double> _logoAnimation;
  AnimationController _logoAnimationController;

  final _opacityTween =  Tween<double>(begin: 0.1, end: 1.0);

  @override
  void initState() {
    super.initState();
    _logoAnimationController =  AnimationController(
        vsync: this, duration:  Duration(milliseconds: 1000));
    _logoAnimation =  CurvedAnimation(
        parent: _logoAnimationController, curve: Curves.easeIn);
    _logoAnimationController.addListener(() => this.setState(() {}));
    _logoAnimationController.forward();

    _logoAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        appUtil.gotoPage(
          context,
           AppNavigatorView(),
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _logoAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Material(
      color: Colors.black87,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           Transform.translate(
            offset:  Offset(0.0, _logoAnimation.value * -20),
            child:  Opacity(
              opacity: _opacityTween.evaluate(_logoAnimation),
              child:  Logo(20.0, MainAxisAlignment.center),
            ),
          )
        ],
      ),
    );
  }
}
