import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(children:[
           Row(children: [
             Text("Toggle Dark Theme"),
             Switch(onChanged: (bool val){
              Brightness brightness = val ? Brightness.dark : Brightness.light;
              setState((){
               
              });
              
             }, value: false,)
           ],)
         ]),
       )
    );
  }
}