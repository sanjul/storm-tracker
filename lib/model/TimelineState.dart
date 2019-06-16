import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

class TimelineState extends ChangeNotifier {
  StormsData _stormsData;
  List<Storm> _stormsList;

  List<Storm> get stormsList => _stormsList;

  TimelineState() {
    _stormsData = new  Injector().stormsData;
  }

  void loadStormsList() async {
    print("### Loading storms list####");
    _stormsList = await _stormsData.fetchStormsList();
    stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));
    notifyListeners();
  }

  Future deleteStorm(Storm storm) async {
    await _stormsData.deleteStormRecord(storm);
    loadStormsList();
    return Future.value(storm);
  }

  Future undoStormDelete(Storm storm) async {
    await _stormsData.saveStormRecord(null, storm);
    loadStormsList();
    return Future.value(storm);
  }
}
