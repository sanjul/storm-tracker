import 'dart:async';

class Storm{
  DateTime startDatetime;
  DateTime endDatetime;
  String notes;

  Storm({this.startDatetime, this.endDatetime, this.notes});

  
}

abstract class StormsData {
  Future <List <Storm>> fetchStormsList();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}