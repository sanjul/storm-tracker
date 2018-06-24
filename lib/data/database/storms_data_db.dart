import 'dart:async';

import 'package:stormtr/data/storms_data.dart';
import 'database_helper.dart';

class StormsDataDb implements StormsData {
  static const String SQL_CREATE_TABLE_STORM_EVENT =
      "CREATE TABLE storm_event(" +
          "id INTEGER PRIMARY KEY," +
          "startDatetime TEXT," +
          "endDatetime TEXT," +
          "notes TEXT," +
          "intensity INT," + 
          "flux INT)";

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
  Future<int> saveStormRecord(int stormId, Storm storm) async {
    var dbClient = await DatabaseHelper().db;
    int _stormId = stormId;

    if (stormId == null) {
      _stormId = await dbClient.insert("storm_event", storm.toMap());
    } else {
      int rowsUpdated = await dbClient.update("storm_event", storm.toMap(),
          where: "id=?", whereArgs: [stormId]);
     
      print("No of rows updated =" + rowsUpdated.toString());
    }

    return Future.value(_stormId);
  }

  @override
  Future<Storm> findStormRecord(int stormId) async {
    Storm _foundItem;

    if (stormId != null) {
      var dbClient = await DatabaseHelper().db;
      List<Map> listData = await dbClient
          .rawQuery("SELECT * FROM storm_event WHERE id = ?", [stormId]);

      if (listData != null && listData.isNotEmpty) {
        _foundItem = new Storm.fromMap(listData[0]);
      }
    }

    return Future.value(_foundItem);
  }
}
