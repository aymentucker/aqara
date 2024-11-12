import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider with ChangeNotifier {
  bool _isNotificationsEnabled = false;

  bool get isNotificationsEnabled => _isNotificationsEnabled;

  NotificationProvider() {
    _loadFromPrefs();
  }

  toggleNotifications(bool value) async {
    _isNotificationsEnabled = value;
    await _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isNotificationsEnabled = prefs.getBool('notifications') ?? true;
    notifyListeners();
  }

  _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', _isNotificationsEnabled);
  }
}
