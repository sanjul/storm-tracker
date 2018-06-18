import 'package:flutter/material.dart';
import 'package:side_header_list_view/side_header_list_view.dart';

import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/modules/storms_list_presenter.dart';
import 'package:stormtr/pages/storm_record_page.dart';
import 'package:stormtr/util/AppUtil.dart';

import '../ui/logo.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> implements StormsListViewContract {
  StormsListPresenter _presenter;
  List<Storm> _stormsList;
  bool _loadFailed;

  //constructor
  HomePageState() {
    _presenter = new StormsListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _presenter.loadStormsList();
  }

  @override
  void onLoadStormsListComplete(List<Storm> stormsList) {
    setState(() {
      _stormsList = stormsList;
      _stormsList.sort((a, b) => b.startDatetime.compareTo(a.startDatetime));
      _loadFailed = false;
    });
  }

  @override
  void onLoadStormsListError(dynamic err) {
    _loadFailed = true;
    print("Error occured: " + err.toString());
    // TODO: implement onLoadStormsListError
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Logo(25.0, MainAxisAlignment.start),
      ),
      body: _buildStormsListBody(),
      // drawer: new Drawer(
      //   child: new ListView(
      //     children: <Widget>[
      //       new ListTile(
      //         title: new Text("Hello"),
      //       )
      //     ],
      //   ),
      // ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          appUtil.gotoPage(context, new StormRecord(null), true);
        },
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

    if (_stormsList.isEmpty){
      return new Text("");
    }

    return new SideHeaderListView(
      itemCount: _stormsList.length,
      itemExtend: 100.0,
      headerBuilder: (BuildContext context, int index) {
        return new Padding(
          padding: new EdgeInsets.all(10.0),
          child: new Card(
            child: new Padding(
              padding: new EdgeInsets.all(2.0),
              child: Text(
                appUtil.getYear(_stormsList[index].startDatetime),
                textScaleFactor: 1.2,
              ),
            ),
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return new InkWell(
            onTap: () {
              appUtil.gotoPage(context,
                  new StormRecord(_stormsList[index].startDatetime), true);
            },
            child: new ListTile(
              leading: Container(
                width: 40.0,
                padding: new EdgeInsets.all(1.0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  border: new Border.all(width: 2.0),
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      appUtil.getDay(_stormsList[index].startDatetime),
                      textScaleFactor: 2.0,
                    ),
                    Text(
                        appUtil.formatToMonth(_stormsList[index].startDatetime))
                  ],
                ),
              ),
              title: new Row(
                children: <Widget>[
                  new Text(
                      appUtil.formatDate(_stormsList[index].startDatetime)),
                  new Icon(Icons.arrow_right),
                  new Text(appUtil.formatDate(_stormsList[index].endDatetime)),
                ],
              ),
              subtitle: new Text(_stormsList[index].notes ?? ""),
              isThreeLine: true,
            ));
      },
      hasSameHeader: (int a, int b) {
        return _stormsList[a].startDatetime.year ==
            _stormsList[b].startDatetime.year;
      },
    );
  }
}
