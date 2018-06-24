import 'dart:async';

class Storm {
  int id;
  DateTime startDatetime;
  DateTime endDatetime;
  String notes;
  int intensity;
  int flux;

  String get startDateDB => startDatetime.toIso8601String();
  String get endDateDB => endDatetime.toIso8601String();

  Storm({this.startDatetime, this.endDatetime, this.notes, this.intensity, this.flux});

  Storm.fromMap(Map<String, dynamic> map) {
    id = map["id"];
    startDatetime = map['startDatetime'] != null? 
         DateTime.parse(map['startDatetime']) : null;
    endDatetime = map['endDatetime'] != null ? 
         DateTime.parse(map['endDatetime']) : null;
    notes = map['notes'];
    intensity = map['intensity'];
    flux = map['flux'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['startDatetime'] = startDatetime != null ? startDatetime.toIso8601String() : null;
    map['endDatetime'] = endDatetime != null ? endDatetime.toIso8601String() : null;
    map['notes'] = notes;
    map['intensity'] = intensity;
    map['flux'] = flux;
    return map;
  }
}

abstract class StormsData {
  Future<List<Storm>> fetchStormsList();
  Future<int> saveStormRecord(int stormId, Storm storm);
  Future<bool> deleteStormRecord(Storm storm);
  Future<Storm> findStormRecord(int stormId);
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}
