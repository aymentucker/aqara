import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';
import 'package:glassmorphism/glassmorphism.dart';

import '../providers/device_provider.dart';
import '../screens/room_control_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Aqara',
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: GoogleFonts.poppins().fontFamily)),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.withOpacity(0.3),
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () => Navigator.pushNamed(context, '/settings'),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/workroom_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Glassmorphic Overlay
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 120.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: deviceProvider.deviceStates.length,
              itemBuilder: (context, index) {
                String device = deviceProvider.deviceStates.keys.elementAt(index);
                return OpenContainer(
                  transitionType: ContainerTransitionType.fade,
                  openBuilder: (context, _) => RoomControlScreen(),
                  closedElevation: 0,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  closedBuilder: (context, openContainer) => GestureDetector(
                    onTap: openContainer,
                    child: GlassmorphicContainer(
                      width: double.infinity,
                      height: 200,
                      borderRadius: 20,
                      blur: 20,
                      alignment: Alignment.bottomCenter,
                      border: 1.5,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.05),
                        ],
                        stops: [0.1, 1],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.black12,
                          Colors.white.withOpacity(0.5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  deviceProvider.isDeviceOn(device)
                                      ? Icons.lightbulb
                                      : Icons.lightbulb_outline,
                                  size: 40,
                                  color: deviceProvider.isDeviceOn(device)
                                      ? Colors.yellow
                                      : Colors.white,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    deviceProvider.toggleDevice(device);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: deviceProvider.isDeviceOn(device)
                                          ? Colors.yellow.withOpacity(0.8)
                                          : Colors.grey.withOpacity(0.5),
                                    ),
                                    child: const Icon(
                                      Icons.power_settings_new,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              device,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
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
                  ),
                );
              },
            ),
          ),
          // Custom Bottom Navigation Bar
          Positioned(
            bottom: 0,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.symmetric(vertical:15),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavBarItem(
                        context,
                        icon: Icons.work_outline,
                        isSelected: true,
                      ),
                      _buildNavBarItem(
                        context,
                        icon: Icons.chair,
                        isSelected: false,
                      ),
                      _buildNavBarItem(
                        context,
                        icon: Icons.bed,
                        isSelected: false,
                      ),
                      _buildNavBarItem(
                        context,
                        icon: Icons.kitchen,
                        isSelected: false,
                      ),
                      _buildNavBarItem(
                        context,
                        icon: Icons.shower,
                        isSelected: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(BuildContext context,
      {required IconData icon, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        // Handle item tap
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : Colors.black.withOpacity(0.7),
        ),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: isSelected ? Colors.black : Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
