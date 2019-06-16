import 'package:flutter/material.dart';

class WelcomeNote extends StatelessWidget {
  final String _instruction;

  WelcomeNote(this._instruction);

  @override
  Widget build(BuildContext context) {
    return welcomeNote();
  }

 Widget welcomeNote() {
    return SafeArea(
          child: Center(
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                Icons.filter_vintage,
                color: Colors.purpleAccent,
                size: 80.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              new Text(
                _instruction,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}