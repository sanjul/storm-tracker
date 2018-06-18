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
  Future<bool> saveStormRecord(Storm storm) {
    for ( Storm oldst in _stormsList){
      if(oldst.startDatetime == storm.startDatetime){
        _stormsList.remove(oldst);
        break;
      }
    }
    _stormsList.add(storm);
    return Future.value(true);
  }

  @override
  Future<Storm> findStormRecord(DateTime startDatetime) {
    Storm _foundItem;

    for ( Storm storm in _stormsList){
      if(storm.startDatetime == startDatetime){
        _foundItem = storm;
        break;
      }
    }

    return Future.value(_foundItem);
  }

}
