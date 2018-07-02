import 'package:flutter/material.dart';

typedef ViewBuilder = Widget Function();

class Navigatable {
  IconData _icon;
  String _title;
  ViewBuilder _builder;

  Navigatable({@required String title, @required ViewBuilder builder, IconData icon}){
    this._title = title;
    this._builder = builder;
    this._icon = icon;
  }
  
  
  String get title => this._title;
  IconData get icon => this._icon;
  ViewBuilder get build => _builder;
}