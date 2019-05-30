import 'package:flutter/foundation.dart';
import 'package:stormtr/data/home_data.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';


class HomeState extends ChangeNotifier{
  StormsData _stormsData;
  HomeData _homeData;

  HomeData get homeData => _homeData;

  HomeState() {
    _stormsData = new Injector().stormsData;
  }

  void loadHome() {
     _stormsData
        .fetchStormsList()
        .then((list){
          _homeData = HomeData.prepare(list);
          notifyListeners();
        })
        .catchError((error){
          print("Error occured: " + error);
          // @TODO : Handle error
        });
  }

}
