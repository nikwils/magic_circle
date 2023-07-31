import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsProvider extends StateNotifier<String> {
  SettingsProvider() : super('');

  Color _newColor = Colors.white;
  Color get newColor => _newColor;
  set setNewColor(Color color) => _newColor = color;

  int _newSpeed = 2000;
  int get newSpeed => _newSpeed;
  set setNewSpeed(int speed) => _newSpeed = speed;

  Curve _newCurve = Curves.linear;
  Curve get newCurve => _newCurve;
  set setNewCurve(Curve speed) => _newCurve = speed;
}
