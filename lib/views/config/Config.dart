import 'package:flutter/material.dart';
import 'package:stormtr/views/chart_stormy_days.dart';
import 'package:stormtr/views/chart_sunny_days.dart';
import 'package:stormtr/views/home_view.dart';
import 'package:stormtr/views/navigation/navigatable.dart';
import 'package:stormtr/views/settings_view.dart';
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
                icon: Icons.cloud,
                title: "Stormy Days",
                builder: () => StormyDaysChart()),
            Navigatable(
                icon: Icons.wb_sunny,
                title: "Sunny days",
                builder: () => SunnyDaysChart()),
          ],
        ),
        Navigatable(
            icon: Icons.settings,
            title: "Settings",
            builder: () => SettingsView())
      ];
}
