import 'package:flutter/material.dart';

typedef ViewBuilder = Widget Function();

class Navigatable {
  IconData icon;
  String title;
  ViewBuilder builder;
  List<Navigatable> views;
  // Constructor
  Navigatable({
    @required this.title,
    this.builder, 
    this.icon,
    this.views
    });
}