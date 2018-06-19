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

  Future loadStorm(int stormId) async {
    if (stormId == null){
      _view.onLoadStormComplete(null);
    }
    _stormsData
          .findStormRecord(stormId)
           .then((record) => _view.onLoadStormComplete(record))
           .catchError((error) => _view.onError());
    
  }

  Future saveStorm(int stormId, Storm storm) async{
    _stormsData
          .saveStormRecord(stormId, storm)
          .then((isInserted) => _view.onSaveStormComplete(isInserted))
          .catchError((error) => _view.onError() );
  }
}