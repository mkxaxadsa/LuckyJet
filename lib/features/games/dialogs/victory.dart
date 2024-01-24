import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_games/features/games/difficulty/difficulty.dart';
import 'package:lucky_games/features/games/widgets/button.dart';
import 'package:lucky_games/features/games/widgets/opaque_container.dart';

import '../../../consts.dart';
import '../../../router/router.dart';

void showVictoryDialog(
    BuildContext context, List<Color> colors, Difficulty difficulty) {
  var width = MediaQuery.of(context).size.width;
  var height = MediaQuery.of(context).size.height;
  var pixelRatio = MediaQuery.of(context).devicePixelRatio;
  var textTheme = Theme.of(context).textTheme;
  YYDialog().build(context)
    ..width = width / 2
    ..height = height
    ..backgroundColor = Colors.transparent
    ..barrierDismissible = false
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    }
    ..widget(
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: width / 2,
            height: height / 1.6,
            margin: EdgeInsets.only(top: height / 4.4),
            decoration: BoxDecoration(
              boxShadow: [difficulty.shadow],
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: colors,
              ),
              borderRadius: BorderRadius.circular(10.sp),
            ),
          ),
          Column(
            children: [
              Image.asset(
                'assets/shared/cup.png',
              ),
              Text(
                'Game over'.toUpperCase(),
                style: textTheme.displayMedium?.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height / 40),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OpaqueContainer(
                      difficulty: difficulty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/shared/lives.png'),
                          Text(
                            '+1',
                            style: textTheme.displayMedium?.copyWith(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )),
                  SizedBox(width: width / 40),
                  OpaqueContainer(
                      difficulty: difficulty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/shared/coins.png'),
                          Text(
                            '+${difficulty.coinsReward}',
                            style: textTheme.displayMedium?.copyWith(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(height: height / 40),
              Button(
                text: 'GO HOME',
                callback: (p0) => context.router.pushAndPopUntil(
                  const LandingRoute(),
                  predicate: (_) => false,
                ),
                difficulty: difficulty,
              ),
            ],
          ),
        ],
      ),
    )
    ..show();
}
