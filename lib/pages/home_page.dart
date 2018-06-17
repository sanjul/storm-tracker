import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/modules/storms_presenter.dart';
import '../ui/logo.dart';
import 'package:intl/intl.dart';
import 'package:sticky_header_list/sticky_header_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> implements StormsListViewContract {
  StormsListPresenter _stormsListPresenter;
  List<Storm> _stormsList;
  List<dynamic> _stormsListGrouped;
  bool _loadFailed;

  //constructor
  HomePageState() {
    _stormsListPresenter = new StormsListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _stormsListPresenter.loadStormsList();
  }

  @override
  void onLoadStormsListComplete(List<Storm> stormsList) {
    setState(() {
      _stormsListGrouped = new List<dynamic>();

      _stormsList = stormsList;
      _stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));

      int currentYear = new DateTime.now().year;
      for (int i = 0; i < _stormsList.length; i++) {
        Storm storm = _stormsList[i];
        int year = storm.startDatetime.year;
        if (currentYear != year) {
          _stormsListGrouped.add(year);
          currentYear = year;
        }

        _stormsListGrouped.add(storm);
      }

      _loadFailed = false;
    });
  }

  @override
  void onLoadStormsListError() {
    _loadFailed = true;
    // TODO: implement onLoadStormsListError
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Logo(25.0, MainAxisAlignment.start),
      ),
      body: _buildStormsListBody(),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new ListTile(
              title: new Text("Hello"),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Record a Storm',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget _buildStormsListBody() {
    if (_loadFailed == true) {
      return new Center(child: new Text("Load failed"));
    }

    if (_stormsList == null) {
      return new Center(child: CircularProgressIndicator());
    }

    return new StickyList.builder(
        itemCount: _stormsListGrouped.length,
        builder: (BuildContext context, int index) {
          final dynamic item = _stormsListGrouped[index];
          final formatter = new DateFormat('dd/MMMM/yyyy');
          final monthFormatter = new DateFormat('MMM');

          if (item is int) {
            return new HeaderRow(
                child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.toString(),
                      textScaleFactor: 1.5,
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                new Divider(height: 2.0,)
              ],
            ));
          }

          Storm storm = item;

          return RegularRow(
            child: new ListTile(
              leading: Container(
                width: 40.0,
                padding: new EdgeInsets.all(2.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  border: new Border.all(width: 2.0),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      storm.startDatetime.day.toString(),
                      textScaleFactor: 2.0,
                    ),
                    Text(monthFormatter.format(storm.startDatetime))
                  ],
                ),
              ),
              title: new Row(
                children: <Widget>[
                  new Text(formatter.format(storm.startDatetime)),
                  new Icon(Icons.arrow_right),
                  new Text(formatter.format(storm.endDatetime)),
                ],
              ),
              subtitle: new Text(storm.notes),
              isThreeLine: true,
            ),
          );
        });
  }
}
