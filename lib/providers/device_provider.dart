import 'package:flutter/material.dart';

class DeviceProvider with ChangeNotifier {
  // Private device states
  Map<String, bool> _deviceStates = {
    'Light': false,
    'Heater': false,
    'Fan': true,
  };

  // Public getter to access device states from outside
  Map<String, bool> get deviceStates => _deviceStates;

  bool isDeviceOn(String deviceId) => _deviceStates[deviceId] ?? false;

  void toggleDevice(String deviceId) {
    _deviceStates[deviceId] = !_deviceStates[deviceId]!;
    notifyListeners();
  }
}
