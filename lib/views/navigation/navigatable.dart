import 'package:flutter/material.dart';

typedef ViewBuilder = Widget Function();

class Navigatable {
  IconData icon;
  String title;
  ViewBuilder builder;

  // Constructor
  Navigatable({
    @required this.title,
    @required this.builder, 
    this.icon});
}