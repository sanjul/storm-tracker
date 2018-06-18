import 'dart:async';

import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

abstract class StormsRecordViewContract {
  void onLoadStormComplete(Storm storm);
  void onError();

  void onSaveStormComplete(bool isInserted);


}

class StormsRecordPresenter {
  StormsRecordViewContract _view;
  StormsData _stormsData;

  StormsRecordPresenter(this._view) {
    _stormsData = new Injector().stormsData;
  }

  Future loadStorm(DateTime startDatetime) async {
    if (startDatetime == null){
      _view.onLoadStormComplete(null);
    }
    _stormsData
          .findStormRecord(startDatetime)
           .then((record) => _view.onLoadStormComplete(record))
           .catchError((error) => _view.onError());
    
  }

  Future saveStorm(Storm storm) async{
    _stormsData
          .saveStormRecord(storm)
          .then((isInserted) => _view.onSaveStormComplete(isInserted))
          .catchError((error) => _view.onError() );
  }
}