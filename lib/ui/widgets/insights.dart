import 'package:flutter/material.dart';
import 'package:stormtr/data/home_data.dart';

class Insights extends StatelessWidget {
  final HomeData data;

  Insights({this.data});

  @override
  Widget build(BuildContext context) {
    // if (_homeData.stats.isNotEmpty)

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(children: [
        _buildHeader(context),
        _buildTable(context),
        _buildPrediction(),
      ]),
    );
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
}
