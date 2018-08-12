import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/util/DateUtil.dart';

class HomeData {
  List<Storm> _stormsList;
  Storm _lastStorm;
  int _avgDuration = 0;
  int _avgGap = 0;
  int _totalDays = 0;
  int _totalGap = 0;

  int _diffCount = 0;
  int _gapCount = 0;
  DateTime _predictedNextStormDate;

  List<String> _stats = new List();
  List<String> get stats => _stats;

  // int get averageDuration => _avgDuration;
  // int get averageGap => _avgGap;
  Storm get lastStorm => _lastStorm;
  bool get isEmpty => _stormsList.isEmpty;
  bool get isNotEmpty => !isEmpty;
  bool get isStormInProgress => _lastStorm?.endDatetime == null;
  bool get isNoStormInProgress => !isStormInProgress;

  HomeData.prepare(List<Storm> stormsList) {
    _stormsList = stormsList;

    _stormsList.sort((a, b) => a.startDatetime.compareTo(b.startDatetime));

    _stormsList?.forEach((st) {
      if (st.startDatetime != null && st.endDatetime != null) {
        int daysDiff = st.endDatetime.difference(st.startDatetime).inDays;
        _totalDays += daysDiff;
        _diffCount++;
      }

      if (_lastStorm?.endDatetime != null && st.startDatetime != null) {
        _totalGap += st.startDatetime.difference(_lastStorm.endDatetime).inDays;
        _gapCount++;
      }

      _lastStorm = st;
    });

    if (_totalDays > 0) _avgDuration = (_totalDays / _diffCount).round();
    if (_gapCount > 0) _avgGap = (_totalGap / _gapCount).round();

    if (_avgDuration > 0) _stats.add("On average, a storm lasts for about $_avgDuration days");
    if (_gapCount > 0) _stats.add("On average, there is about $_avgGap days between storms");

    if(isNoStormInProgress && stormsList.length > 1){
      _predictedNextStormDate = _lastStorm.endDatetime.add(Duration(days: _avgGap));
      String dispDate = dateUtil.formatDate(_predictedNextStormDate);
      int numDays= _predictedNextStormDate.difference(DateTime.now()).inDays;
      String addlInfo;
      if(numDays == -1){
        addlInfo = "That was supposed to be yesterday. Let's give it a day or two...";
      } else if(numDays < -1){
        addlInfo = "That was supposed to be ${numDays.abs()} days ago...";
      } else if(numDays == 0){
        addlInfo = "That's today! Get your storm defences handy!";
      } else if(numDays == 1){
        addlInfo = "That's tomorrow. Be prepared, keep your storm defences handy!";
      } else if(numDays > 1){
        addlInfo = "That's $numDays days to go!";
      }

      if (addlInfo != null){
        addlInfo = "\n$addlInfo";
      }
      _stats.add("Ideally, next storm should start on $dispDate. $addlInfo");
    }
  }
}
