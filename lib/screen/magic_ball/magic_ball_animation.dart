import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/data/providers/providers.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/magic_ball_text_animation.dart';
import 'package:surf_practice_magic_ball/screen/settings/settings_provider.dart';

class MagicBallAnimations extends ConsumerStatefulWidget {
  final String reading;
  const MagicBallAnimations(this.reading, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MagicBallAnimationsState();
}

class _MagicBallAnimationsState extends ConsumerState<MagicBallAnimations>
    with TickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  bool showMagicBall = false;
  Color newColor = Colors.white;

  SettingsProvider? notifier;

  void ballSettings() {
    notifier = ref.read(settingsProvider.notifier);
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: notifier!.newSpeed))
      ..repeat(reverse: true);

    animation = CurvedAnimation(parent: controller!, curve: notifier!.newCurve);
  }

  @override
  void initState() {
    super.initState();
    ballSettings();
  }

  @override
  void didUpdateWidget(covariant MagicBallAnimations oldWidget) {
    ballSettings();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    newColor = notifier!.newColor;
    const double sizeBall = 200;
    final deviceHeight = MediaQuery.of(context).size.height;

    void autoStartAnimation() {
      controller!.repeat(reverse: true);
      setState(() {
        showMagicBall = false;
      });
    }

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: deviceHeight / 1.5,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final Size biggest = constraints.biggest;
              return Stack(children: [
                PositionedTransition(
                  rect: RelativeRectTween(
                    begin: RelativeRect.fromSize(
                      Rect.fromLTWH(biggest.width / 2 - sizeBall / 2, 0,
                          sizeBall, sizeBall),
                      biggest,
                    ),
                    end: RelativeRect.fromSize(
                      Rect.fromLTWH(
                        biggest.width / 2 - sizeBall / 2,
                        biggest.height - sizeBall,
                        sizeBall,
                        sizeBall,
                      ),
                      biggest,
                    ),
                  ).animate(
                    CurvedAnimation(
                        parent: controller!, curve: notifier!.newCurve),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(magicBallProvider.notifier).fetchAnswer();
                      showMagicBall = true;
                      controller!.stop();

                      Timer(const Duration(seconds: 10), () {
                        autoStartAnimation();
                      });
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            TweenAnimationBuilder(
                              builder: (BuildContext context, Color? color,
                                  Widget? child) {
                                return ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    color!,
                                    BlendMode.modulate,
                                  ),
                                  child:
                                      Image.asset('assets/imgs/magic_ball.png'),
                                );
                              },
                              tween: ColorTween(
                                  begin: Colors.white, end: newColor),
                              duration: const Duration(seconds: 1),
                            ),
                            Center(
                              child: showMagicBall
                                  ? MagicBallTextAnimations(widget.reading)
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            },
          ),
        ),
        ScaleTransition(
          scale: animation!,
          child: TweenAnimationBuilder(
            builder: (BuildContext context, Color? color, Widget? child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(color!, BlendMode.modulate),
                child: Image.asset('assets/imgs/ellipse.png'),
              );
            },
            tween: ColorTween(begin: Colors.white, end: newColor),
            duration: const Duration(seconds: 1),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
