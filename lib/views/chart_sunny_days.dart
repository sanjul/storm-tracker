import 'package:flutter/material.dart';
import 'package:stormtr/data/graph_data.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/modules/graph_presenter.dart';
import 'package:stormtr/ui/WelcomeNote.dart';

class SunnyDaysChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SunnyDaysChartState();
  }
}

class SunnyDaysChartState extends State<SunnyDaysChart>
    implements GraphViewContract {
  GraphViewPresenter _presenter;
  List<MyRow> _chartData;
  //constructor
  SunnyDaysChartState() {
    _presenter = new GraphViewPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadStormsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_chartData == null) {
      return new Center(
        child: CircularProgressIndicator(),
      );
    }

    if(_chartData.isEmpty){
      return WelcomeNote("Not enough records available to show this chart. \nCome back here later!");
    }

    var _series = [
      charts.Series<MyRow, DateTime>(
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.gap,
        id: "Gap",
        data: _chartData,
      )
    ];

    var chart = new charts.TimeSeriesChart(
      _series,
      animate: true,
      domainAxis: new charts.DateTimeAxisSpec(
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
          day: new charts.TimeFormatterSpec(
              format: 'd', transitionFormat: 'MM/dd/yyyy'),
        ),
      ),
    );

    return new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new Container(
        child: chart,
      ),
    );
  }

  @override
  void onError(error) {
    print(error);
  }

  @override
  void onLoadGraphComplete(GraphData graphData) {
    setState(() {

      _chartData = [];
      Storm _lastStorm;
      graphData.stormsList.forEach((st) {
 
       if (_lastStorm?.endDatetime != null && st.startDatetime != null) {
        int gap = st.startDatetime.difference(_lastStorm.endDatetime).inDays.abs();
        _chartData.add(MyRow(_lastStorm.endDatetime, gap));
      }

      _lastStorm = st;
      });

    });
  }

}

class MyRow {
  final DateTime timeStamp;
  final int gap;
  MyRow(this.timeStamp, this.gap);
}
