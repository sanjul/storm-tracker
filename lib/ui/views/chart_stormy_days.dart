import 'package:flutter/material.dart';
import 'package:stormtr/model/ChartState.dart';
import 'package:stormtr/ui/widgets/TImeSeriesChart.dart';

class StormyDaysChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TimeSeriesChart.init(ChartType.STORMY_DAYS);
  }
}
