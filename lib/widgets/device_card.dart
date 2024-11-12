import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String deviceName;
  final bool isOn;
  final Function toggleCallback;

  DeviceCard({required this.deviceName, required this.isOn, required this.toggleCallback});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(isOn ? Icons.power : Icons.power_off),
        title: Text(deviceName),
        trailing: Switch(
          value: isOn,
          onChanged: (value) => toggleCallback(),
        ),
      ),
    );
  }
}
