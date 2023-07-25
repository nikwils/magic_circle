import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MagicBallAnimations extends ConsumerStatefulWidget {
  const MagicBallAnimations({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MagicBallAnimationsState();
}

class _MagicBallAnimationsState extends ConsumerState<MagicBallAnimations>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  stopAnimation() {
    controller?.stop();
  }

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);

    controller?.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animation!,
      child: Image.asset('assets/imgs/magic_ball.png'),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
