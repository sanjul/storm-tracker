import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

enum ChartType{STORMY_DAYS, SUNNY_DAYS}

class ChartState extends ChangeNotifier {
  StormsData _stormsData;
  List<Storm> _stormsList;
  List<MyRow> _chartData;

  List<MyRow> get chartData => _chartData;

  ChartState() {
    _stormsData = new Injector().stormsData;
  }

  Future loadChartData(ChartType chartType) async {
    _stormsList = await _stormsData.fetchStormsList();
    _stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));


    if(chartType == ChartType.STORMY_DAYS){

        _chartData = [];
        _stormsList.forEach((st) {
          if (st.startDatetime != null && st.endDatetime != null) {
            _chartData.add(MyRow(st.startDatetime,
                st.endDatetime.difference(st.startDatetime).inDays));
          }
        });

    } else if (chartType == ChartType.SUNNY_DAYS){
        _chartData = [];
        Storm _lastStorm;
        _stormsList.forEach((st) {
          if (_lastStorm?.endDatetime != null && st.startDatetime != null) {
            int gap =
                st.startDatetime.difference(_lastStorm.endDatetime).inDays.abs();
            _chartData.add(MyRow(_lastStorm.endDatetime, gap));
          }

          _lastStorm = st;
        });
    }

    notifyListeners();
  }
}

class MyRow {
  final DateTime timeStamp;
  final int val;
  MyRow(this.timeStamp, this.val);
}
