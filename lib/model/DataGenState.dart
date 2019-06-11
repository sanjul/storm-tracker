import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:stormtr/data/storms_data.dart';

import '../dependency_injection.dart';

class DataGenState extends ChangeNotifier {
  int _recordCount = 0;
  StormsData _stormsData;
  Storm _firstStorm;
  List<Storm> _stormsList;
  bool _isGenerating = false;

  int get recordCount => _recordCount;
  bool get isGenerating => _isGenerating;

  DataGenState() {
    _stormsData = new Injector().stormsData;
  }

  Future init() async {
    _stormsList = await _stormsData.fetchStormsList();
    _stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));

    _recordCount = _stormsList.length;

    if (_stormsList != null && _stormsList.isNotEmpty) {
      _firstStorm = _stormsList.first;
    }

    notifyListeners();
  }

  void toggleGen() {
    _isGenerating = !_isGenerating;
    if (_isGenerating) {
      generateData();
    }
  }

  Future deleteEverything() async {
    if (_isGenerating) {
      return;
    }

    init();
    List<Storm> storms = await _stormsData.fetchStormsList();
    for (final storm in storms) {
      if (_isGenerating) {
        break;
      }

      _stormsData.deleteStormRecord(storm);
      _recordCount--;
      notifyListeners();
    }

    init();
  }

  Future generateData() async {
    Random rand = Random();
    if (_firstStorm == null) {
      _firstStorm = Storm(startDatetime: DateTime.now());
    }

    while (_isGenerating) {
      _recordCount += 1;

      int diffDays = 25 + rand.nextInt(10);

      DateTime newEndDate =
          _firstStorm.startDatetime.subtract(Duration(days: diffDays));
      DateTime newStartDate =
          newEndDate.subtract(Duration(days: 4 + rand.nextInt(3)));
      _firstStorm.startDatetime = newStartDate;
      _firstStorm.endDatetime = newEndDate;
      _firstStorm.notes = "Auto generated record - $_recordCount";
      _firstStorm.flux = rand.nextInt(4);
      _firstStorm.intensity = rand.nextInt(4);

      // create new record
      await _stormsData.saveStormRecord(null, _firstStorm);

      notifyListeners();

      if (_recordCount >= 1500) {
        _isGenerating = false;
        notifyListeners();
        return;
      }
    }
  }
}
