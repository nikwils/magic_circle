import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/magic_ball_screen.dart';
import 'package:surf_practice_magic_ball/screen/routes.dart';
import 'package:surf_practice_magic_ball/screen/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('ru', 'RU')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ru', 'RU'),
        child: const MyApp(),
      ),
    ),
  );
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      theme: ThemeManager().themeDataAndroid,
      debugShowCheckedModeBanner: false,
      routes: Routes.routesMap,
      home: const MagicBallScreen(),
    );
  }
}
