import 'dart:async';

import 'package:stormtr/data/graph_data.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

abstract class GraphViewContract {
  void onLoadGraphComplete(GraphData graphData);
  void onError(dynamic error);
}

class GraphViewPresenter {
  GraphViewContract _view;
  StormsData _stormsData;

  GraphViewPresenter(this._view) {
    _stormsData = new Injector().stormsData;
  }

  Future loadStormsList() async {
    _stormsData.fetchStormsList().then((List<Storm> list) {
      _view.onLoadGraphComplete(GraphData(list));
    }).catchError((error) => _view.onError(error));
  }
}
