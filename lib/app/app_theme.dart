import 'package:flutter/material.dart';

const ink = Color(0xFF1E1F4B);
const brand = Color(0xFF3B3FA8);
const lavender = Color(0xFFE6E7FA);
const paper = Color(0xFFF6F5F1);
const muted = Color(0xFF5B5E7A);

ThemeData buildAppTheme() => ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: paper,
  colorScheme: ColorScheme.fromSeed(seedColor: brand)
      .copyWith(primary: brand, onPrimary: Colors.white),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(color: ink, fontWeight: FontWeight.w800),
    titleLarge: TextStyle(color: ink, fontWeight: FontWeight.w800),
    titleMedium: TextStyle(color: ink, fontWeight: FontWeight.w700),
    bodyMedium: TextStyle(color: ink),
    bodySmall: TextStyle(color: muted),
  ),
  navigationBarTheme: const NavigationBarThemeData(
    backgroundColor: Colors.white,
    indicatorColor: lavender,
  ),
);
