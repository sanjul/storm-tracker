import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(children:[
         Row(children: [
           Text("Toggle Dark Theme"),
           Switch(onChanged: (bool val){
            // Theme.of(context). = Brightness.dark;
           }, value: false,)
         ],)
       ])
    );
  }
}