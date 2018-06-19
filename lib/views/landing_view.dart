import 'package:flutter/material.dart';
import '../util/AppUtil.dart';
import '../ui/logo.dart';
import 'home_view.dart';

class LandingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LandingViewState();
  }
}

class LandingViewState extends State<LandingView>
    with SingleTickerProviderStateMixin {
  Animation<double> _logoAnimation;
  AnimationController _logoAnimationController;

  final _opacityTween = new Tween<double>(begin: 0.1, end: 1.0);

  @override
  void initState() {
    super.initState();
    _logoAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1000));
    _logoAnimation = new CurvedAnimation(
        parent: _logoAnimationController, curve: Curves.easeIn);
    _logoAnimationController.addListener(() => this.setState(() {}));
    _logoAnimationController.forward();

    _logoAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        appUtil.gotoPage(context, new HomeView());
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
    return new Material(
      color: Colors.black87,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Transform.translate(
            offset: new Offset(0.0, _logoAnimation.value * -10),
            child: new Opacity(
              opacity: _opacityTween.evaluate(_logoAnimation),
              child: new Logo(50.0, MainAxisAlignment.center),
            ),
          )
        ],
      ),
    );
  }
}