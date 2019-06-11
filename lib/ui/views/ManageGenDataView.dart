import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stormtr/model/DataGenState.dart';

class ManageGenDataView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ManageGenDataViewState();
  }

  static ChangeNotifierProvider init() {
    return ChangeNotifierProvider<DataGenState>(
        builder: (_) {
          DataGenState state = DataGenState();
          state.init();
          return state;
        },
        child: ManageGenDataView());
  }
}

class ManageGenDataViewState extends State<ManageGenDataView> {
  @override
  Widget build(BuildContext context) {
    DataGenState dataGenState = Provider.of<DataGenState>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(dataGenState.recordCount.toString(),
                    style: TextStyle(fontSize: 90)),
                Text("Storms"),
              ],
            ),
            _buildControls(context),
          ],
        )),
      ),
    );
  }

  _buildControls(BuildContext context) {

    DataGenState state = Provider.of<DataGenState>(context);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
          child: state.isGenerating ? Text("Stop Generating") :Text("Generate"),
          color: state.isGenerating  ? Colors.redAccent : Colors.greenAccent,
          onPressed: (){
            state.toggleGen();
          },
        ),

        if(!state.isGenerating)
          RaisedButton(
            child: Text("Delete everything"),
            onPressed: (){
              state.deleteEverything();
            },
          )
      ],
    );
  }
}
