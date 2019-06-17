import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stormtr/ui/config/Config.dart';
import 'package:stormtr/ui/navigation/navigatable.dart';

class AppState with ChangeNotifier {
  static const PREF_IS_DARK_MODE_ENABLED = "isDarkModeEnabled";
  SharedPreferences _prefs;

  List<Navigatable> _views;
  Navigatable _currentView;

  List<Navigatable> get views => _views;
  Navigatable get currentView => this._currentView;
  bool _backdropVisible = false;

  bool get isBackdropVisible => _backdropVisible;

  String get viewTitle => isBackdropVisible ? "Menu" : currentView.title;

  AppState(SharedPreferences prefs) {
    _prefs = prefs;
    /* List of views that can be loaded in home view */
    _views = Config.navigatables;

    /* Set Home view as the default view */
    _currentView = _views[0];
  }

  bool _isDarkModeEnabled;

  void setDarkModeEnabled(bool isEnabled) {
    _isDarkModeEnabled = isEnabled;
    _prefs.setBool(PREF_IS_DARK_MODE_ENABLED, _isDarkModeEnabled);
    notifyListeners();
  }

  bool get isDarkModeEnabled {
    if (_isDarkModeEnabled == null) {
      _isDarkModeEnabled = _prefs.getBool(PREF_IS_DARK_MODE_ENABLED) ?? false;
    }
    return _isDarkModeEnabled;
  }

  void navigateToView(Navigatable view) {
    _currentView = view;
    notifyListeners();
  }

  void toggleBackdrop() {
    _backdropVisible = !_backdropVisible;
    notifyListeners();
  }

  Tween<double> getBackdropToggleTween(double min, double max) {
    double begin, end;

    if (isBackdropVisible) {
      begin = min;
      end = max;
    } else {
      begin = max;
      end = min;
    }
    
    return Tween<double>(begin: begin, end: end);
  }
}
