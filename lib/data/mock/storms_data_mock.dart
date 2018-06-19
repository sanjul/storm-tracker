import 'dart:async';

import 'package:stormtr/data/storms_data.dart';

class MockStormsData implements StormsData {

  static var _stormsList = <Storm>[
    // new Storm(
    //     startDatetime: DateTime.parse("2016-01-05 10:30:00"),
    //     endDatetime: DateTime.parse("2016-06-09 10:00:00"),
    //     notes: "The First storm ever"),
    // new Storm(
    //     startDatetime: DateTime.parse("2016-01-12 10:00:00"),
    //     endDatetime: DateTime.parse("2016-08-15 10:00:00"),
    //     notes: "The Third storm"),
    // new Storm(
    //     startDatetime: DateTime.parse("2016-07-06 10:00:00"),
    //     endDatetime: DateTime.parse("2016-07-09 10:00:00"),
    //     notes: "The Second storm"),
    // new Storm(
    //     startDatetime: DateTime.parse("2017-07-06 10:00:00"),
    //     endDatetime: DateTime.parse("2017-07-09 10:00:00"),
    //     notes: "The Second storm"),
    // new Storm(
    //     startDatetime: DateTime.parse("2017-07-06 10:00:00"),
    //     endDatetime: DateTime.parse("2017-07-09 10:00:00"),
    //     notes: "The Second storm"),
    // new Storm(
    //     startDatetime: DateTime.parse("2017-07-06 10:00:00"),
    //     endDatetime: DateTime.parse("2017-07-09 10:00:00"),
    //     notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2016-07-06 10:00:00"),
        endDatetime: DateTime.parse("2016-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2016-07-06 10:00:00"),
        endDatetime: DateTime.parse("2016-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2016-07-06 10:00:00"),
        endDatetime: DateTime.parse("2016-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2017-01-04 10:00:00"),
        endDatetime: DateTime.parse("2017-01-08 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2017-02-06 10:00:00"),
        endDatetime: DateTime.parse("2017-02-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2017-03-06 10:00:00"),
        endDatetime: DateTime.parse("2017-03-09 10:00:00"),
        notes: "The Second storm"),
  ];

  @override
  Future<List<Storm>> fetchStormsList() {
    return Future.value(_stormsList);
  }

  @override
  Future<bool> deleteStormRecord(Storm storm) {

    _stormsList.remove(storm);
    return Future.value(true);
  }

  @override
  Future<bool> saveStormRecord(int stormId, Storm storm) {
    if(stormId == null){
      _stormsList.add(storm);
    } else {
      _stormsList[stormId] = storm;
    }
    
    return Future.value(true);
  }

  @override
  Future<Storm> findStormRecord(int stormId) {
    Storm _foundItem;
    
    if(stormId != null){
       _foundItem = _stormsList[stormId];  
    }

    return Future.value(_foundItem);
  }

}
