import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shake/shake.dart';
import 'package:surf_practice_magic_ball/data/providers/providers.dart';
import 'package:surf_practice_magic_ball/screen/magic_ball/magic_ball_animation.dart';

class MagicBallWidget extends ConsumerStatefulWidget {
  const MagicBallWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MagicBallWidgetState();
}

class _MagicBallWidgetState extends ConsumerState<MagicBallWidget> {
  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(
      onPhoneShake: () {
        ref.read(magicBallProvider.notifier).fetchAnswer();
      },
      minimumShakeCount: 1,
      shakeSlopTimeMS: 500,
      shakeCountResetTime: 3000,
      shakeThresholdGravity: 2.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    final magicBall = ref.watch(magicBallProvider);

    return magicBall.when(
      data: (data) {
        return Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 16, 12, 44),
                Color.fromARGB(255, 3, 0, 0),
              ],
              stops: [0.1, 0.95],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(56.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      ref.read(magicBallProvider.notifier).fetchAnswer();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/imgs/magic_ball.png'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              data.reading,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Image.asset('assets/imgs/ellipse.png'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'global.pressing_ball'.tr(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 144, 144, 144),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 16, 12, 44),
                Color.fromARGB(255, 3, 0, 0),
              ],
              stops: [0.1, 0.95],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(56.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Center(
                  child: TextButton(
                    onPressed: () {
                      ref.read(magicBallProvider.notifier).fetchAnswer();
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('assets/imgs/magic_ball.png'),
                        Image.asset(
                          'assets/imgs/vector.png',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'global.error'.tr(),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Image.asset('assets/imgs/ellipse_red.png'),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'global.pressing_ball'.tr(),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 144, 144, 144),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        );
      },
      loading: () => Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 16, 12, 44),
              Color.fromARGB(255, 3, 0, 0),
            ],
            stops: [0.1, 0.95],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(56.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Center(
                child: TextButton(
                  onPressed: () {
                    ref.read(magicBallProvider.notifier).fetchAnswer();
                  },
                  child: const Stack(
                    alignment: Alignment.center,
                    children: [MagicBallAnimations()],
                  ),
                ),
              ),
              Image.asset('assets/imgs/ellipse.png'),
              TextButton(
                onPressed: () {},
                child: Text(
                  'global.download'.tr(),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 144, 144, 144),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
