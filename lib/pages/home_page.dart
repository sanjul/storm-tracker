import 'package:flutter/material.dart';
import '../ui/logo.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Logo(25.0, MainAxisAlignment.start),
      ),
      drawer: new Drawer(child: Material(color: Colors.blueGrey,),),
      body: new Material(
        color: Colors.yellow,
      ),
    );
  }
}
