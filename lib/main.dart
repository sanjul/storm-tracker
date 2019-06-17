import 'package:flutter/material.dart';
import 'package:stormtr/dependency_injection.dart';
import 'package:stormtr/the_app.dart';

Future main() async {
  
  Injector.configure(
    /* Make sure primaryDataSource is set to SQLLITE for production */
    primaryDataSource: DataSource.SQLLITE,
  );

  
  Widget app = await TheApp.init();

  runApp(app);
}
