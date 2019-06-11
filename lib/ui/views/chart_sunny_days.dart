import 'package:flutter/material.dart';
import 'package:stormtr/model/ChartState.dart';
import 'package:stormtr/ui/widgets/TImeSeriesChart.dart';

class SunnyDaysChart extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return TimeSeriesChart.init(ChartType.SUNNY_DAYS);
  }
}