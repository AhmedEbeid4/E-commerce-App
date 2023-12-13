import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashWidget extends StatelessWidget {
  const SplashWidget(
      {super.key,
      required this.futureFunction,
      required this.onSuccess,
      required this.onFail});

  final Future<bool> futureFunction;
  final Function onSuccess;
  final Function onFail;

  @override
  Widget build(BuildContext context) {
    bool showFutureBuilder = true;

    return FutureBuilder(
      future: futureFunction,
      builder: (ctx, snapshot) {
        print(
            'SPLASH_SCREEN_VARIABLES :: ${snapshot.hasData} $showFutureBuilder');

        if (!showFutureBuilder) {
          return const SizedBox();
        }

        if (snapshot.hasData) {
          print(
              'SPLASH_SCREEN_VARIABLES IN IF :: ${snapshot.data} $showFutureBuilder');
          Future.delayed(Duration.zero, () {
            if (snapshot.data!) {
              onSuccess();
              showFutureBuilder = false;
            } else if (!snapshot.data!) {
              onFail();
            }
          });
        }

        return Center(
          child: Lottie.asset('assets/animations/splash_anim.json'),
        );
      },
    );
  }
}
