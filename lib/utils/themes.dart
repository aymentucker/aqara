import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light, // Ensure this matches the ThemeData brightness
  ),
  brightness: Brightness.light,
  textTheme: GoogleFonts.poppinsTextTheme(),
  useMaterial3: true,
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark, // Ensure this matches the ThemeData brightness
  ),
  brightness: Brightness.dark,
  textTheme: GoogleFonts.poppinsTextTheme(),
  useMaterial3: true,
);
