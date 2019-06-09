import 'package:stormtr/data/storms_data.dart';
import 'package:stormtr/util/DateUtil.dart';

class HomeData {
  List<Storm> _stormsList;
  Storm _lastStorm;
  int _avgStormyDays = 0;
  int _avgSunnyDays = 0;
  int _totalStormyDays = 0;
  int _totalSunnyDays = 0;
  int _shortestSunnyDays = 0;
  int _shortestStormyDays = 0;
  int _longestSunnyDays = 0;
  int _longestStormyDays = 0;

  int _stormSlotCount = 0;
  int _sunSlotCount = 0;
  DateTime _predictedNextStormDate;

  String _prediction;
  String get predictionText => _prediction;

  Storm get lastStorm => _lastStorm;
  bool get isEmpty => _stormsList.isEmpty;
  bool get isNotEmpty => !isEmpty;
  bool get isStormInProgress => _lastStorm?.endDatetime == null;
  bool get isNoStormInProgress => !isStormInProgress;

  int get avgSunnyDays => _avgSunnyDays;
  int get avgStormyDays => _avgStormyDays;
  int get shortestSunnyDays => _shortestSunnyDays;
  int get shortestStormyDays => _shortestStormyDays;
  int get longestSunnyDays => _longestSunnyDays;
  int get longestStormyDays => _longestStormyDays;
  bool get canShowInsights => _avgStormyDays > 0;
  int currentDuration = 0;

  HomeData.prepare(List<Storm> stormsList) {
    _stormsList = stormsList;

    _stormsList.sort((a, b) => a.startDatetime.compareTo(b.startDatetime));

    _stormsList?.forEach((st) {
      if (st.startDatetime != null && st.endDatetime != null) {
        int stormDuration = st.endDatetime.difference(st.startDatetime).inDays;
        _totalStormyDays += stormDuration;
        _stormSlotCount++;

        if (stormDuration > _longestStormyDays) {
          _longestStormyDays = stormDuration;
        }

        if (_shortestStormyDays == 0 || stormDuration < _shortestStormyDays) {
          _shortestStormyDays = stormDuration;
        }
      }

      if (_lastStorm?.endDatetime != null && st.startDatetime != null) {
        int sunDuration =
            st.startDatetime.difference(_lastStorm.endDatetime).inDays;
        _totalSunnyDays += sunDuration;
        _sunSlotCount++;

        if (sunDuration > _longestSunnyDays) {
          _longestSunnyDays = sunDuration;
        }

        if (_shortestSunnyDays == 0 || sunDuration < _shortestSunnyDays) {
          _shortestSunnyDays = sunDuration;
        }
      }

      currentDuration = DateTime.now().difference(st.startDatetime).inDays;

      _lastStorm = st;
    });

    if (_totalStormyDays > 0)
      _avgStormyDays = (_totalStormyDays / _stormSlotCount).round();
    if (_sunSlotCount > 0)
      _avgSunnyDays = (_totalSunnyDays / _sunSlotCount).round();

    if (isNoStormInProgress && stormsList.length > 1) {
      _predictedNextStormDate =
          _lastStorm.endDatetime.add(Duration(days: _avgSunnyDays));
      String dispDate = dateUtil.formatDate(_predictedNextStormDate);
      int numDays = _predictedNextStormDate.difference(DateTime.now()).inDays;
      String addlInfo;

      if (numDays == -1) {
        addlInfo =
            "should ideally,have started yesterday.\nIf not, give it a day or two...";
      } else if (numDays < -1) {
        addlInfo =
            "should likely have started on $dispDate,\nwhich was about ${numDays.abs()} days ago...";
      } else if (numDays == 0) {
        addlInfo = "might be starting TODAY!!\nGet storm-defences ready!";
      } else if (numDays == 1) {
        addlInfo =
            "likely be starting tomorrow.\nBe prepared, keep storm-defences handy!";
      } else if (numDays > 1) {
        addlInfo =
            "likely be starting in $numDays days.\nThat's on $dispDate.";
      }

      _prediction = "Next storm $addlInfo";
    } else if (isStormInProgress) {
      if (currentDuration == 0) {
        _prediction = "Storm started today!";
      }else if(currentDuration == 1){
        _prediction = "Storm started yesterday!";
      } else {
        _prediction = "It is " +
            currentDuration.toString() +
            " days since storm started";
      }
    }
  }
}
