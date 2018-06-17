import 'dart:async';

import 'package:stormtr/data/storms_data.dart';

class MockStormsData implements StormsData {
  @override
  Future<List<Storm>> fetchStormsList() {
    return Future.value(_stormsList);
  }

  var _stormsList = <Storm>[
    new Storm(
        startDatetime: DateTime.parse("2016-06-05 10:30:00"),
        endDatetime: DateTime.parse("2016-06-09 10:00:00"),
        notes: "The First storm ever"),
    new Storm(
        startDatetime: DateTime.parse("2016-08-12 10:00:00"),
        endDatetime: DateTime.parse("2016-08-15 10:00:00"),
        notes: "The Third storm"),
    new Storm(
        startDatetime: DateTime.parse("2016-07-06 10:00:00"),
        endDatetime: DateTime.parse("2016-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2017-07-06 10:00:00"),
        endDatetime: DateTime.parse("2017-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2017-07-06 10:00:00"),
        endDatetime: DateTime.parse("2017-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2017-07-06 10:00:00"),
        endDatetime: DateTime.parse("2017-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2018-07-06 10:00:00"),
        endDatetime: DateTime.parse("2018-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2018-07-06 10:00:00"),
        endDatetime: DateTime.parse("2018-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2018-07-06 10:00:00"),
        endDatetime: DateTime.parse("2018-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2019-07-06 10:00:00"),
        endDatetime: DateTime.parse("2019-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2019-07-06 10:00:00"),
        endDatetime: DateTime.parse("2019-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2019-07-06 10:00:00"),
        endDatetime: DateTime.parse("2019-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2005-07-06 10:00:00"),
        endDatetime: DateTime.parse("2016-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2005-07-06 10:00:00"),
        endDatetime: DateTime.parse("2016-07-09 10:00:00"),
        notes: "The Second storm"),
    new Storm(
        startDatetime: DateTime.parse("2005-07-06 10:00:00"),
        endDatetime: DateTime.parse("2016-07-09 10:00:00"),
        notes: "The Second storm"),
  ];
}
