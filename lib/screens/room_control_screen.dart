import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../providers/device_provider.dart';

class RoomControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Room Control', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.5),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white , size: 24,),
            ),
          ),
        ) ,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/room_control_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphic device controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Control Devices',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(1.5, 1.5),
                        blurRadius: 3.0,
                        color: Colors.black45,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: deviceProvider.deviceStates.length,
                    itemBuilder: (context, index) {
                      String device = deviceProvider.deviceStates.keys.elementAt(index);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: GlassmorphicContainer(
                          width: double.infinity,
                          height: 120,
                          borderRadius: 20,
                          blur: 15,
                          alignment: Alignment.bottomCenter,
                          border: 1.5,
                          linearGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.2),
                              Colors.white.withOpacity(0.05),
                            ],
                            stops: [0.1, 1],
                          ),
                          borderGradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.5),
                              Colors.white.withOpacity(0.5),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                // Device Icon
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: deviceProvider.isDeviceOn(device)
                                        ? Colors.yellow.withOpacity(0.8)
                                        : Colors.grey.withOpacity(0.5),
                                  ),
                                  child: Icon(
                                    deviceProvider.isDeviceOn(device)
                                        ? Icons.lightbulb
                                        : Icons.lightbulb_outline,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                // Device Name and Status
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        device,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        deviceProvider.isDeviceOn(device) ? "Status: On" : "Status: Off",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white70,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Switch to control device
                                Switch.adaptive(
                                  value: deviceProvider.isDeviceOn(device),
                                  onChanged: (value) {
                                    deviceProvider.toggleDevice(device);
                                  },
                                  activeColor: Colors.yellow,
                                  inactiveThumbColor: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
