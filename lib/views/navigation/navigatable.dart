import 'package:flutter/material.dart';

typedef ViewBuilder = Widget Function();

class Navigatable {
  IconData icon;
  String title;
  ViewBuilder builder;
  List<Navigatable> tabs;
  // Constructor
  Navigatable({
    this.title,
    this.builder, 
    this.icon,
    this.tabs
    });
}