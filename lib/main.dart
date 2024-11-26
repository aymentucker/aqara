import 'package:aqara/providers/device_provider.dart';
import 'package:aqara/providers/notification_provider.dart';
import 'package:aqara/providers/theme_provider.dart';
import 'package:aqara/screens/home_screen.dart';
import 'package:aqara/screens/room_control_screen.dart';
import 'package:aqara/screens/settings_screen.dart';
import 'package:aqara/utils/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


/// => https://www.behance.net/gallery/210003217/Aqara-Smart-Home-App-UI-UX-Design?tracking_source=search_projects%7Cblog+app+ui+design&l=50
///

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),

      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aqara Smart Home',
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/room_control': (context) => RoomControlScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
