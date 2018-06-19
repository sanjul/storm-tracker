import 'package:flutter/material.dart';

import 'package:stormtr/dependency_injection.dart';
import 'views/landing_view.dart';

void main() {
  Injector.configure(
    primaryDataSource: DataSource.SQLLITE,
  );

  runApp(new MaterialApp(
    home: new LandingPage(),
    theme: new ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.dark,
      // primaryColor: Colors.blueGrey,
      // accentColor: Colors.blue,
    ),
  ));
}
