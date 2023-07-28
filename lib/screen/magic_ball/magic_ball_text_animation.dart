import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MagicBallTextAnimations extends ConsumerStatefulWidget {
  final String text;
  const MagicBallTextAnimations(this.text, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MagicBallTextAnimationsState();
}

class _MagicBallTextAnimationsState
    extends ConsumerState<MagicBallTextAnimations>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);
    controller?.forward();
  }

  @override
  void didUpdateWidget(covariant MagicBallTextAnimations oldWidget) {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!);
    controller?.forward();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation!,
      child: Container(
        width: 190,
        height: 190,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromARGB(170, 16, 12, 44),
        ),
        child: Center(
          child: Text(
            widget.text,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
