import 'package:flutter/material.dart';
import 'package:stormtr/ui/views/ManageGenDataView.dart';
import 'package:stormtr/ui/views/chart_stormy_days.dart';
import 'package:stormtr/ui/views/chart_sunny_days.dart';
import 'package:stormtr/ui/views/home_view.dart';
import 'package:stormtr/ui/navigation/navigatable.dart';
import 'package:stormtr/ui/views/timeline_view.dart';

class Config {
  /// Navigatables.
  /// This defines app navigation.
  /// It Used in conjunction with AppNavigatorView
  static List<Navigatable> get navigatables => [
        Navigatable(
          icon: Icons.home,
          title: "Home",
          builder: HomeView.init,
        ),
        Navigatable(
          title: "Timeline",
          icon: Icons.view_list,
          builder: TimelineView.init,
        ),
        Navigatable(
          icon: Icons.timeline,
          title: "Charts",
          tabs: [
            Navigatable(
              icon: Icons.cloud,
              title: "Stormy Days",
              builder: () => StormyDaysChart(),
            ),
            Navigatable(
              icon: Icons.wb_sunny,
              title: "Sunny days",
              builder: () => SunnyDaysChart(),
            ),
          ],
        ),
        Navigatable(
          icon: Icons.ac_unit,
          title: "Data",
          builder: ManageGenDataView.init,
        )
      ];
}
