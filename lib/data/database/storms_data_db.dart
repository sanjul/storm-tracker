import 'dart:async';

import 'package:stormtr/data/storms_data.dart';
import 'database_helper.dart';

class StormsDataDb implements StormsData {
  static const String SQL_CREATE_TABLE_STORM_EVENT =
      "CREATE TABLE storm_event(" +
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
  Future<bool> saveStormRecord(int stormId, Storm storm) async {
    var dbClient = await DatabaseHelper().db;
    int res;

    if (stormId == null) {
      res = await dbClient.insert("storm_event", storm.toMap());
    } else {
      res = await dbClient.update("storm_event", storm.toMap(),
          where: "WHERE id=?", whereArgs: [stormId]);
    }

    return Future.value(res > 0);
  }

  @override
  Future<Storm> findStormRecord(int stormId) async {
    var dbClient = await DatabaseHelper().db;
    List<Map> listData = await dbClient
        .rawQuery("SELECT * FROM storm_event WHERE id = ?", [stormId]);

    if (listData == null || listData.isEmpty) {
      return Future.value(null);
    }

    return Future.value(new Storm.fromMap(listData[0]));
  }
}
