import 'package:flutter/material.dart';

import 'package:stormtr/dependency_injection.dart';
import 'views/landing_view.dart';

void main() {
  
  Injector.configure(
    /* Make sure primaryDataSource is set to SQLLITE for production */
    primaryDataSource: DataSource.MOCK,
  );

  runApp(new MaterialApp(
    home: new LandingView(),
    theme: new ThemeData(
      primarySwatch: Colors.purple,
      brightness: Brightness.light,
      fontFamily: "QuarmicSans",
      // primaryColor: Colors.blueGrey,
      // accentColor: Colors.blue,
    ),
  ));
}
