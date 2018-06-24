import 'dart:async';

import 'package:stormtr/data/storms_data.dart';

class MockStormsData implements StormsData {

  static var _stormsList = <Storm>[
     new Storm(
        startDatetime: DateTime.parse("2016-02-01 10:00:00"),
        endDatetime: DateTime.parse("2016-02-05 10:00:00"),
        notes: "Mock data, this is some storm data, that is worth a lot of lines, becuase why not?"
        + "This is a new line, but we don't know much."
        + "\n another new line. But storm is made of storms."
        + "Mock data can have as much garbage text as you want,"
        + "But we need a lot of lines here to make sure UI doesn't break",
        intensity: 3,
        flux:2),
    new Storm(
        startDatetime: DateTime.parse("2016-03-06 10:00:00"),
        endDatetime: DateTime.parse("2016-03-09 10:00:00"),
        notes: null,
        flux:2),
    new Storm(
        startDatetime: DateTime.parse("2016-01-10 10:00:00"),
        endDatetime: DateTime.parse("2016-01-14 10:00:00"),
        notes: "",
        intensity:5),
    new Storm(
        startDatetime: DateTime.parse("2017-01-04 10:00:00"),
        endDatetime: null,
        notes: "Mock data, tsunamis came this way"),
    new Storm(
        startDatetime: DateTime.parse("2017-02-08 10:00:00"),
        endDatetime: DateTime.parse("2017-02-12 10:00:00"),
        notes: "Mock data, what else, storm, ahem..!"),
    new Storm(
        startDatetime: DateTime.parse("2017-03-06 10:00:00"),
        endDatetime: DateTime.parse("2017-03-09 10:00:00"),
        notes: "Isn't storm's kinda stormy?"),
  ];

  @override
  Future<List<Storm>> fetchStormsList() {
    for (int i = 0; i< _stormsList.length; i++){
      _stormsList[i].id = i;
    }

    return Future.value(_stormsList);
  }

  @override
  Future<bool> deleteStormRecord(Storm storm) {

    _stormsList.remove(storm);
    return Future.value(true);
  }

  @override
  Future<int> saveStormRecord(int stormId, Storm storm) {
    int _stormId = stormId;
    if(stormId == null){
      _stormsList.add(storm);
      _stormId = _stormsList.indexOf(storm);
    } else {
      _stormsList[_stormId] = storm;
    }
    
    return Future.value(_stormId);
  }

  @override
  Future<Storm> findStormRecord(int stormId) {
    Storm _foundItem;
    
    for(Storm storm in _stormsList){
      if(storm.id == stormId){
        _foundItem = storm;  
        break;
      }
    }

    return Future.value(_foundItem);
  }

}
