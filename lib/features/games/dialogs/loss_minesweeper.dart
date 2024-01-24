import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_games/features/games/widgets/button.dart';
import 'package:lucky_games/features/games/widgets/opaque_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts.dart';
import '../../../main.dart';
import '../../../router/router.dart';
import '../../landing/landing_screen.dart';
import '../difficulty/difficulty.dart';
import 'out_of_lives.dart';

void showMinesweeperLossDialog(
    BuildContext context, List<Color> colors, Game game, Difficulty difficulty,
    {int? level}) {
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
                'assets/minesweeper/bomb.png',
              ),
              Text(
                'Game is lost'.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              Text(
                'You smelled a bomb!'.toUpperCase(),
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: height / 40),
              OpaqueContainer(
                  difficulty: difficulty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/shared/lives.png'),
                      Text(
                        '-1',
                        style:
                            Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 8.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  )),
              SizedBox(height: height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                      text: 'RETRY',
                      callback: (p0) {
                        if (locator<SharedPreferences>().getInt('lives') != 0) {
                          switch (game) {
                            case Game.matchPairs:
                              context.router.pushAndPopUntil(
                                MatchPairsRoute(
                                    difficulty: difficulty, level: level!),
                                predicate: (_) => false,
                              );
                              break;
                            case Game.minesweeper:
                              context.router.pushAndPopUntil(
                                MinesweeperRoute(difficulty: difficulty),
                                predicate: (_) => false,
                              );
                              break;
                            default:
                          }
                        } else {
                          showOutOfLivesDialog(context, difficulty);
                        }
                      },
                      difficulty: difficulty),
                  SizedBox(width: width / 40),
                  Button(
                      text: 'GO HOME',
                      callback: (p0) => context.router.pushAndPopUntil(
                            const LandingRoute(),
                            predicate: (_) => false,
                          ),
                      difficulty: difficulty)
                ],
              )
            ],
          ),
        ],
      ),
    )
    ..show();
}
