import 'package:flutter/material.dart';
import 'package:stormtr/views/duration_vs_date_chart.dart';
import 'package:stormtr/views/gap_vs_date_chart.dart';
import 'package:stormtr/views/home_view.dart';
import 'package:stormtr/views/navigation/navigatable.dart';
import 'package:stormtr/views/timeline_view.dart';

class Config {
  /// Navigatables.
  /// This defines app navigation.
  /// It Used in conjunction with AppNavigatorView
  static List<Navigatable> get navigatables => [
        Navigatable(icon: Icons.home, title: "Home", tabs: [
          Navigatable(
            // title: "Home",
            icon: Icons.home,
            builder: () => HomeView(),
          ),
          Navigatable(
            // title: "Time Line",
            icon: Icons.view_list,
            builder: () => TimelineView(),
          )
        ]),
        Navigatable(
          icon: Icons.timeline,
          title: "Charts",
          tabs: [
            Navigatable(
              title: "Length over Time",
              builder: () => DurationVsDateChart()
            ),
            Navigatable(
              title: "Gap over Time",
              builder: () => GapVsDateChart()
            ),
            
          ],
        ),
      ];
}
