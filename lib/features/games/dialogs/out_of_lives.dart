import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_games/features/games/difficulty/difficulty.dart';
import 'package:lucky_games/features/games/widgets/button.dart';

import '../../../router/router.dart';

void showOutOfLivesDialog(BuildContext context, Difficulty difficulty) {
  var height = MediaQuery.of(context).size.height;
  var textTheme = Theme.of(context).textTheme;
  YYDialog().build(context)
    ..width = MediaQuery.of(context).size.width / 2
    ..backgroundColor = Colors.transparent
    ..barrierDismissible = false
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
        child: child,
      );
    }
    ..widget(
      Container(
        width: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: difficulty.colors,
          ),
          borderRadius: BorderRadius.circular(10.sp),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No lives left!'.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
              Text(
                'You ran out of lives'.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: height / 40),
              Button(
                  text: 'OK',
                  callback: (p0) => context.router.pop(),
                  difficulty: difficulty),
              SizedBox(height: height / 40),
              Button(
                text: 'BUY MORE',
                callback: (p0) => context.router.push(const PurchaseRoute()),
                difficulty: difficulty,
              )
            ],
          ),
        ),
      ),
    )
    ..show();
}
