import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/state/AppState.dart';
import 'package:stormtr/the_app.dart';

Future main() async {
  
  Injector.configure(
    /* Make sure primaryDataSource is set to SQLLITE for production */
    primaryDataSource: DataSource.MOCK,
  );

  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppState>.value(notifier: AppState(prefs),),
    ],
    child: TheApp(),
  ));
}
