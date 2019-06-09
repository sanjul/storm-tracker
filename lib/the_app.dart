import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/state/AppState.dart';
import 'package:stormtr/ui/views/landing_view.dart';

class TheApp extends StatefulWidget {
  @override
  _TheAppState createState() => _TheAppState();
}

class _TheAppState extends State<TheApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingView(),
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Provider.of<AppState>(context).isDarkModeEnabled
            ? Brightness.dark
            : Brightness.light,
        // fontFamily: "QuarmicSans",
        // primaryColor: Colors.blueGrey,
        // accentColor: Colors.blue,
      ),
    );
  }
}
