import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

class StormRecordState extends ChangeNotifier {
  StormsData _stormsData;
  Storm _storm;

  Storm get storm => _storm;

  StormRecordState() {
    _stormsData = new Injector().stormsData;
  }

  Future loadStorm(int stormId) async {
    print("Storm ID  =" + stormId.toString());
    if (stormId != null) {
      _storm = await _stormsData.findStormRecord(stormId);
    }
    
    if(_storm == null){
      // If no record found,
      // Create new object
      _storm = Storm();
    }

    notifyListeners();
  }

  Future<int> saveStorm(int stormId, Storm storm) async {
    stormId = await _stormsData.saveStormRecord(stormId, storm);
    return Future.value(stormId);
  }

}
