import 'package:stormtr/data/storms_data.dart';

class Home {
  List<Storm> _stormsList;
  Storm _lastStorm;
  int _avgDuration = 0;
  int _avgGap = 0;
  int _totalDays = 0;
  int _totalGap = 0;

  int _diffCount = 0;
  int _gapCount = 0;

  int get averageDuration => _avgDuration;
  int get averageGap => _avgGap;
  Storm get lastStorm => _lastStorm;
  bool get isEmpty => _stormsList.isEmpty;
  bool get isNotEmpty => !isEmpty;

  Home.prepare(List<Storm> stormsList) {
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

    if (_totalDays > 0) {
      _avgDuration = (_totalDays / _diffCount).round();
    }

    if (_gapCount > 0) {
      _avgGap = (_totalGap / _gapCount).round();
    }
  }
}
