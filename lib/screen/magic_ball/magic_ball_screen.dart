import 'package:flutter/material.dart';

import 'package:surf_practice_magic_ball/screen/magic_ball/magic_ball_widget.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: MagicBallWidget()),
    );
  }
}
