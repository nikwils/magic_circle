import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:surf_practice_magic_ball/data/providers/providers.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/magic_ball_text_animation.dart';

class MagicBallAnimations extends ConsumerStatefulWidget {
  final Color? newColor;
  final String reading;
  const MagicBallAnimations(this.newColor, this.reading, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MagicBallAnimationsState();
}

class _MagicBallAnimationsState extends ConsumerState<MagicBallAnimations>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;
  Animation<double>? animationEllipse;
  bool showMagicBall = false;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);

    animation = CurvedAnimation(parent: controller!, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
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
          height: deviceHeight / 2,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final Size biggest = constraints.biggest;
              return Stack(children: [
                PositionedTransition(
                  rect: RelativeRectTween(
                          begin: RelativeRect.fromSize(
                              Rect.fromLTWH(biggest.width / 2 - sizeBall / 2, 0,
                                  sizeBall, sizeBall),
                              biggest),
                          end: RelativeRect.fromSize(
                              Rect.fromLTWH(
                                  biggest.width / 2 - sizeBall / 2,
                                  biggest.height - sizeBall,
                                  sizeBall,
                                  sizeBall),
                              biggest))
                      .animate(
                    CurvedAnimation(
                        parent: controller!, curve: Curves.fastOutSlowIn),
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
                                      color!, BlendMode.modulate),
                                  child:
                                      Image.asset('assets/imgs/magic_ball.png'),
                                );
                              },
                              tween: ColorTween(
                                  begin: Colors.white, end: widget.newColor),
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
            tween: ColorTween(begin: Colors.white, end: widget.newColor),
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
