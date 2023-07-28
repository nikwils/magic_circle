import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/screen/settings/settings_widget.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  static const routeName = '/settings';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return const SettingsWidget();
  }
}
