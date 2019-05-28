import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState with ChangeNotifier {

  static const PREF_IS_DARK_MODE_ENABLED = "isDarkModeEnabled";
  SharedPreferences _prefs;
  
  AppState(SharedPreferences prefs)  {
    _prefs = prefs;
  }

  bool _isDarkModeEnabled;

  void setDarkModeEnabled(bool isEnabled) {
    _isDarkModeEnabled = isEnabled;
    _prefs.setBool(PREF_IS_DARK_MODE_ENABLED, _isDarkModeEnabled);
    notifyListeners();
  }

  bool get isDarkModeEnabled {
    if(_isDarkModeEnabled == null){
      _isDarkModeEnabled = _prefs.getBool(PREF_IS_DARK_MODE_ENABLED) ?? false;
    }
    return _isDarkModeEnabled;
  }
}

