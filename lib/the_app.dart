import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stormtr/model/AppState.dart';
import 'package:stormtr/ui/navigation/app_landing_view.dart';

class TheApp extends StatelessWidget {

  static Future<Widget> init() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>.value(
          notifier: AppState(prefs),
        ),
      ],
      child: TheApp(),
    );
  }

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
