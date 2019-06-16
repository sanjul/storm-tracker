import 'package:flutter/material.dart';
import 'package:stormtr/data/home_data.dart';
import 'package:stormtr/model/ChartState.dart';
import 'package:stormtr/ui/widgets/TImeSeriesChart.dart';

class Insights {
  final HomeData data;

  Insights({this.data});

  List<Widget> getWidgetList(BuildContext context) {
    return [
      SizedBox(height:20),
      _buildHeader(context),
      _buildPrediction(),
      _buildChart(ChartType.SUNNY_DAYS),
      _buildChart(ChartType.STORMY_DAYS),
      _buildTable(context),
    ];
  }

  Widget _buildPrediction() {
    if (data?.predictionText != null)
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(data?.predictionText),
          ),
        ),
      );

    return Text('');
  }

  Widget _buildTable(BuildContext context) {
    if (!data.canShowInsights) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
          border:
              TableBorder.all(width: 0.1, color: Theme.of(context).accentColor),
          children: [
            TableRow(children: [
              TableCell(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                    Text(""),
                    Icon(Icons.wb_sunny),
                    Icon(Icons.cloud),
                  ]))
            ]),
            _buildTableRow(
              caption: "Average",
              sunDays: data.avgSunnyDays,
              stormDays: data.avgStormyDays,
            ),
            _buildTableRow(
              caption: "Shortest",
              sunDays: data.shortestSunnyDays,
              stormDays: data.shortestStormyDays,
            ),
            _buildTableRow(
              caption: "Longest",
              sunDays: data.longestSunnyDays,
              stormDays: data.longestStormyDays,
            ),
          ]),
    );
  }

  TableRow _buildTableRow({String caption, int sunDays, int stormDays}) {
    return TableRow(children: [
      TableCell(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text("$caption"),
        Text("$sunDays days"),
        Text("$stormDays days"),
      ]))
    ]);
  }

  Widget _buildHeader(BuildContext context) {
    return Row(children: [
      Icon(
        Icons.wb_incandescent,
        color: Theme.of(context).accentColor,
      ),
      SizedBox(
        width: 10.0,
      ),
      Text(
        "Insights",
        textScaleFactor: 1.5,
        style: TextStyle(
          color: Theme.of(context).accentColor,
        ),
      ),
    ]);
  }

  _buildChart(ChartType chartType) {
    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              chartType == ChartType.STORMY_DAYS ? "Stormy Days" : "Sunny Days",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
                width: 500,
                height: 200,
                child: TimeSeriesChart.init(chartType)),
          ],
        ),
      ),
    );
  }
}
