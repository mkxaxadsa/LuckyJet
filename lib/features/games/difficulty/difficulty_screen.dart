import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/widgets/back.dart';
import 'package:lucky_games/features/landing/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../widgets/coins.dart';
import '../widgets/lives.dart';
import 'difficulty.dart';
import 'difficulty_card.dart';

@RoutePage()
class DifficultyScreen extends StatelessWidget {
  final Game game;
  const DifficultyScreen({super.key, required this.game});

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
                const Align(
                  alignment: Alignment.topLeft,
                  child: Back(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    game.name.toUpperCase(),
                    style: textTheme.displayLarge?.copyWith(
                        fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
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
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DifficultyCard(
                        game: game,
                        difficulty: Difficulty.simple,
                        image: 'assets/difficulty/simple.png',
                        shadows: const [purpleShadow],
                      ),
                      DifficultyCard(
                        game: game,
                        difficulty: Difficulty.middle,
                        image: 'assets/difficulty/middle.png',
                        shadows: const [redShadow],
                      ),
                      DifficultyCard(
                        game: game,
                        difficulty: Difficulty.advanced,
                        image: 'assets/difficulty/advanced.png',
                        shadows: const [orangeShadow],
                      ),
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
