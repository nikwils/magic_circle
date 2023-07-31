import 'package:flutter/material.dart';

class ThemeManager {
  static final _singleton = ThemeManager._internal();
  factory ThemeManager() => _singleton;
  ThemeManager._internal();

  final themeDataAndroid = ThemeData(
    fontFamily: "GillSansC",
    useMaterial3: true,
  );

  Color colorMagicBall = Colors.white;
}
