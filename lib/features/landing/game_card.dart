import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/widgets/button.dart';
import 'package:lucky_games/features/landing/landing_screen.dart';
import 'package:lucky_games/router/router.dart';

class GameCard extends StatelessWidget {
  final Game game;
  final String path;
  final BoxShadow shadow;
  const GameCard({
    Key? key,
    required this.game,
    required this.path,
    required this.shadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;
    var colors;
    switch (game) {
      case Game.matchPairs:
        colors = [
          Color(0xFF662AFB),
          Color(0xFFC94AF6),
        ];
        break;
      case Game.minesweeper:
        colors = [
          Color(0xFFEE2654),
          Color(0xFFFF80B1),
        ];
        break;
      default:
    }
    return Container(
      width: width / 3,
      height: height / 1.8,
      decoration: BoxDecoration(
        boxShadow: [shadow],
        borderRadius: BorderRadius.all(
          Radius.circular(pixelRatio * 10),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: colors,
          stops: const [0, 1],
          transform: const GradientRotation(123.07 * (3.141592653589793 / 180)),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(path),
          Text(
            game.name.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .displayMedium
                ?.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w800),
          ),
          Button(
            text: 'START GAME',
            callback: (p0) => context.router.push(DifficultyRoute(game: game)),
          )
        ],
      ),
    );
  }
}
