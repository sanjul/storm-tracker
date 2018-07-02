import 'package:flutter/material.dart';

class ChartsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ChartsViewState();
  }
}

class ChartsViewState extends State<ChartsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return new Center(child: Text("This screen is under construction"));
  }
}
