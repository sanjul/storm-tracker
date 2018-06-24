import 'package:flutter/material.dart';

import 'package:stormtr/dependency_injection.dart';
import 'views/landing_view.dart';

void main() {
  
  Injector.configure(
    /* Make sure primaryDataSource is set to SQLLITE for production */
    primaryDataSource: DataSource.SQLLITE,
  );

  runApp(new MaterialApp(
    home: new LandingView(),
    theme: new ThemeData(
      primarySwatch: Colors.lightBlue,
      brightness: Brightness.light,
      // primaryColor: Colors.blueGrey,
      // accentColor: Colors.blue,
    ),
  ));
}
