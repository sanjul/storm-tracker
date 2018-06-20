import 'dart:async';

import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

abstract class StormsListViewContract {
  void onLoadStormsListComplete(List <Storm> stormsList);
  void onStormDeleteComplete(bool isDeleted, Storm storm);
  void onError(dynamic error);
}

class StormsListPresenter {
  StormsListViewContract _view;
  StormsData _stormsData;

  StormsListPresenter(this._view) {
    _stormsData = new Injector().stormsData;
  }

  Future loadStormsList() async {
    print("### Loading storms list####");
    _stormsData
        .fetchStormsList()
        .then((list) => _view.onLoadStormsListComplete(list))
        .catchError((error) => _view.onError(error));
  }

  Future deleteStorm(Storm storm) async {
    
    _stormsData.deleteStormRecord(storm)
    .then((isDeleted) => _view.onStormDeleteComplete(isDeleted, storm))
    .catchError((error) => _view.onError(error));
    
  }
}
