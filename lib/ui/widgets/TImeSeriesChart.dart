import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:stormtr/model/ChartState.dart';
import 'package:stormtr/ui/widgets/WelcomeNote.dart';

class TimeSeriesChart extends StatelessWidget {
  static ChangeNotifierProvider init(ChartType chartType) {
    return ChangeNotifierProvider<ChartState>(
        builder: (_) {
          ChartState state = ChartState();
          state.loadChartData(chartType);
          return state;
        },
        child: TimeSeriesChart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    List<MyRow> _chartData = Provider.of<ChartState>(context).chartData;

    if (_chartData == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_chartData.isEmpty) {
      return WelcomeNote(
          "Not enough records available to show this chart");
    }

    var _series = [
      charts.Series<MyRow, DateTime>(
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.val,
        id: "chartVals",
        data: _chartData,
      )
    ];

    var chart = charts.TimeSeriesChart(
      _series,
      animate: true,
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: GridlineRendererSpec(),
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
              format: 'd', transitionFormat: 'MM/dd/yyyy'),
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Container(
        child: SafeArea(child: chart),
      ),
    );
  }
}
