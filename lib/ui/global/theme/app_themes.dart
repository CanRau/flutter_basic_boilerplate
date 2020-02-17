import 'package:flutter/material.dart';

enum AppTheme {
  GreenLight,
  GreenDark,
  BlueLight,
  BlueDark,
}

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.GreenLight: ThemeData(brightness: Brightness.light, primarySwatch: Colors.green),
  AppTheme.GreenDark: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.green),
  AppTheme.BlueLight: ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
  AppTheme.BlueDark: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
};