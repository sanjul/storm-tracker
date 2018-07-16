import 'dart:async';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

abstract class HomeViewContract {
  void onLoadComplete(List <Storm> stormsList);
  void onError(dynamic error);
}

class HomePresenter {
  HomeViewContract _view;
  StormsData _stormsData;

  HomePresenter(this._view) {
    _stormsData = new Injector().stormsData;
  }

  Future loadHome() async {
     _stormsData
        .fetchStormsList()
        .then((list) => _view.onLoadComplete(list))
        .catchError((error) => _view.onError(error));
  }
}
