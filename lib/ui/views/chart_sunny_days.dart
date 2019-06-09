import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:stormtr/model/ChartState.dart';
import 'package:stormtr/ui/widgets/WelcomeNote.dart';

class SunnyDaysChart extends StatelessWidget {
  static ChangeNotifierProvider init() {
    return ChangeNotifierProvider<ChartState>(
        builder: (_) {
          ChartState state = ChartState();
          state.loadChartData(ChartType.SUNNY_DAYS);
          return state;
        },
        child: SunnyDaysChart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }
}


  Widget _buildBody(BuildContext context) {
    List<MyRow> _chartData = Provider.of<ChartState>(context).chartData;
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
        measureFn: (MyRow row, _) => row.val,
        id: "Gap",
        data: _chartData,
      )
    ];

    var chart = new charts.TimeSeriesChart(
      _series,
      animate: true,
      domainAxis: new charts.DateTimeAxisSpec(
        renderSpec: GridlineRendererSpec(),
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

