import 'package:flutter/material.dart';
import '../util/AppUtil.dart';
import '../ui/logo.dart';
import 'home_page.dart';

class LandingPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new LandingPageState();
  }
}

class LandingPageState extends State<LandingPage>{
  @override
  Widget build(BuildContext context) {
    return new Material(
        color: Colors.blueGrey,
        child: new InkWell(

          onTap: () => appUtil.gotoPage(context, new HomePage()),

          child: new Column(
            children: <Widget>[
              new Logo(50.0, MainAxisAlignment.center),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ));
  }

}
