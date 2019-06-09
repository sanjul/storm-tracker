import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:stormtr/data/home_data.dart';
import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/dependency_injection.dart';

enum Mood { SUNNY_DAY, STORMY_DAY }

class HomeState extends ChangeNotifier {
  StormsData _stormsData;
  HomeData _homeData;

  HomeData get homeData => _homeData;

  HomeState() {
    _stormsData = new Injector().stormsData;
  }

  Mood get mood => homeData == null || homeData.isNoStormInProgress
      ? Mood.SUNNY_DAY
      : Mood.STORMY_DAY;

  bool isAnimLoopStarted = false;

  void setAsAnimLoopStarted() {
    isAnimLoopStarted = true;
    notifyListeners();
  }

  String getAnimationName() {
    String animationName = "sunnyday";

    if (homeData != null) {
      if (homeData.isStormInProgress) {
        animationName = isAnimLoopStarted ? "stormyday" : "sunnyday_ends";
      } else {
        animationName = isAnimLoopStarted ? "sunnyday" : "stormyday_ends";
      }
    }

    return animationName;
  }

  void loadHome() {
    _stormsData.fetchStormsList().then((list) {
      _homeData = HomeData.prepare(list);
      isAnimLoopStarted = false;
      notifyListeners();
    }).catchError((error) {
      print("Error occured: " + error);
      // @TODO : Handle error
    });
  }

  void startStormRecord() {
    Storm newStorm = Storm();
    newStorm.startDatetime = DateTime.now();
    _stormsData.saveStormRecord(null, newStorm).then((stormId) => loadHome());
  }

  void stopStormRecord() {
    Storm currentStorm = homeData.lastStorm;
    currentStorm.endDatetime = DateTime.now();
    _stormsData.saveStormRecord(currentStorm.id, currentStorm).then((stormId) {
      loadHome();
    });
  }

  Tween<double> getTween(double min, double max){
    double begin, end;

    if(mood == Mood.SUNNY_DAY){
      begin = min;
      end = max;
    } else {
      begin = max;
      end = min;
    }

    if(isAnimLoopStarted){
      begin = end;
    } 

    return Tween<double>(begin: begin, end: end);   
  }
}
