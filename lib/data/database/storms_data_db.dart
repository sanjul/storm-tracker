import 'dart:async';

import 'package:stormtr/data/storms_data.dart';
import 'database_helper.dart';

class StormsDataDb implements StormsData {

  static const String SQL_CREATE_TABLE_STORM_EVENT = "CREATE TABLE storm_event(" +
        "id INTEGER PRIMARY KEY," +
        "startDatetime TEXT," +
        "endDatetime TEXT," +
        "notes TEXT)";

  @override
  Future<List<Storm>> fetchStormsList() async {
    var dbClient = await DatabaseHelper().db;
    List<Map> listData = await dbClient.rawQuery("SELECT * FROM storm_event");
    List<Storm> storms = new List<Storm>();
    for (Map map in listData) {
      storms.add(new Storm.fromMap(map));
    }

    return Future.value(storms);
  }

  @override
  Future<bool> deleteStormRecord(Storm storm) async {
    var dbClient = await DatabaseHelper().db;
    int res = await dbClient.delete("storm_event",
        where: "startDateTime = ?", whereArgs: [storm.startDateDB]);

    return Future.value(res > 0);
  }

  @override
  Future<bool> saveStormRecord(Storm storm) async {
    await deleteStormRecord(storm);
    var dbClient = await DatabaseHelper().db;
    int res = await dbClient.insert("storm_event", storm.toMap());
    return Future.value(res > 0);
  }

  @override
  Future<Storm> findStormRecord(DateTime startDatetime) async {
    var dbClient = await DatabaseHelper().db;
    List<Map> listData = await dbClient.rawQuery(
        "SELECT * FROM storm_event WHERE startDateTime = ?",
        [startDatetime.toIso8601String()]);

    if (listData == null || listData.isEmpty) {
      return Future.value(null);
    }

    return Future.value(new Storm.fromMap(listData[0]));
  }
}
