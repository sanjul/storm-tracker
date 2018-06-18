import 'dart:async';

class Storm {
  DateTime startDatetime;
  DateTime endDatetime;
  String notes;

  String get startDateDB => startDatetime.toIso8601String();
  String get endDateDB => endDatetime.toIso8601String();

  Storm({this.startDatetime, this.endDatetime, this.notes});

  Storm.fromMap(Map<String, dynamic> map) {
    startDatetime = map['startDatetime'] != null? 
         DateTime.parse(map['startDatetime']) : null;
    endDatetime = map['endDatetime'] != null ? 
         DateTime.parse(map['endDatetime']) : null;
    notes = map['notes'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["startDatetime"] = startDatetime != null ? startDatetime.toIso8601String() : null;
    map["endDatetime"] = endDatetime != null ? endDatetime.toIso8601String() : null;
    map["notes"] = notes;
    return map;
  }
}

abstract class StormsData {
  Future<List<Storm>> fetchStormsList();
  Future<bool> saveStormRecord(Storm storm);
  Future<bool> deleteStormRecord(Storm storm);
  Future<Storm> findStormRecord(DateTime startDatetime);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
