import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/widgets/button.dart';
import 'package:lucky_games/features/landing/landing_screen.dart';
import 'package:lucky_games/main.dart';
import 'package:lucky_games/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dialogs/out_of_lives.dart';
import 'difficulty.dart';

class DifficultyCard extends StatefulWidget {
  final Game game;
  final Difficulty difficulty;
  final String image;
  final List<BoxShadow> shadows;

  const DifficultyCard(
      {super.key,
      required this.game,
      required this.difficulty,
      required this.image,
      required this.shadows});

  @override
  State<DifficultyCard> createState() => _DifficultyCardState();
}

class _DifficultyCardState extends State<DifficultyCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: width / 4.5,
      height: height / 1.8,
      decoration: BoxDecoration(
        boxShadow: widget.shadows,
        borderRadius: BorderRadius.all(
          Radius.circular(pixelRatio * 10),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: widget.difficulty.colors,
          stops: const [0, 1],
          transform: const GradientRotation(123.07 * (3.141592653589793 / 180)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.image),
          Text(
            widget.difficulty.name.toUpperCase(),
            style: textTheme.displayLarge
                ?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w800),
          ),
          Button(
            text: 'START GAME',
            callback: (p0) {
              if (locator<SharedPreferences>().getInt('lives') != 0) {
                switch (widget.game) {
                  case Game.matchPairs:
                    context.router.push(MatchPairsLevelRoute(
                        difficulty: widget.difficulty,
                        colors: widget.difficulty.colors));
                    break;
                  case Game.minesweeper:
                    context.router
                        .push(MinesweeperRoute(difficulty: widget.difficulty));
                    break;
                  default:
                }
              } else {
                showOutOfLivesDialog(context, widget.difficulty);
              }
            },
          )
        ],
      ),
    );
  }
}
