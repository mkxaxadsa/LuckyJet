import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucky_games/features/games/match_pairs/level_card.dart';
import 'package:lucky_games/features/games/widgets/back.dart';
import 'package:lucky_games/features/games/widgets/coins.dart';
import 'package:lucky_games/features/games/widgets/home.dart';
import 'package:lucky_games/features/games/widgets/lives.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../router/router.dart';
import '../difficulty/difficulty.dart';

@RoutePage()
class MatchPairsLevelScreen extends StatelessWidget {
  final Difficulty difficulty;
  final List<Color> colors;
  const MatchPairsLevelScreen(
      {super.key, required this.difficulty, required this.colors});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/bg2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: pixelRatio * 10,
              right: pixelRatio * 10,
              left: pixelRatio * 10,
            ),
            child: Stack(
              children: [
                const Row(
                  children: [
                    Back(),
                    SizedBox(width: 5),
                    Home(),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Lives(),
                    SizedBox(width: 5),
                    Coins(),
                  ],
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Match pairs'.toUpperCase(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...List.generate(5, (index) {
                        return LevelCard(
                          difficulty: difficulty,
                          id: index + 1,
                          isLocked: locator<SharedPreferences>().getStringList(
                                      'MatchPairs${difficulty.name}')![index] ==
                                  'unlocked'
                              ? false
                              : true,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
