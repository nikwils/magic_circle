import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:surf_practice_magic_ball/data/model/answer.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/magic_ball_provider.dart';
import 'package:surf_practice_magic_ball/screen/settings/settings_provider.dart';

final magicBallProvider =
    StateNotifierProvider<MagicBallProvider, AsyncValue<Answer>>((ref) {
  return MagicBallProvider();
});

final settingsProvider = StateNotifierProvider<SettingsProvider, String>((ref) {
  return SettingsProvider();
});
