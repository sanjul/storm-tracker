import 'dart:async';

import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

abstract class StormsRecordViewContract {
  void onLoadStormComplete(Storm storm);
  void onError(String error);

  void onSaveStormComplete(int stormId);


}

class StormsRecordPresenter {
  StormsRecordViewContract _view;
  StormsData _stormsData;

  StormsRecordPresenter(this._view) {
    _stormsData = new Injector().stormsData;
  }

  Future loadStorm(int stormId) async {
    print("Storm ID  =" + stormId.toString());
    if (stormId == null){
      _view.onLoadStormComplete(null);
    }
    _stormsData
          .findStormRecord(stormId)
           .then((record) => _view.onLoadStormComplete(record))
           .catchError((error) => _view.onError(error));
    
  }

  Future saveStorm(int stormId, Storm storm) async{
    _stormsData
          .saveStormRecord(stormId, storm)
          .then((stormId) => _view.onSaveStormComplete(stormId))
          .catchError((error) => _view.onError(error) );
  }
}