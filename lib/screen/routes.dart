import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/magic_ball_screen.dart';
import 'package:surf_practice_magic_ball/screen/settings/settings_screen.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routesMap = {
    MagicBallScreen.routeName: ((ctx) => const MagicBallScreen()),
    SettingsScreen.routeName: ((ctx) => const SettingsScreen()),
  };
}
