import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/widgets/lives.dart';
import 'package:lucky_games/features/games/widgets/logo.dart';
import 'package:lucky_games/features/games/widgets/settings.dart';
import 'package:lucky_games/features/landing/game_card.dart';
import 'package:lucky_games/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../games/widgets/coins.dart';

enum Game {
  matchPairs('Match pairs'),
  minesweeper('Minesweeper');

  final String name;

  const Game(this.name);
}

@RoutePage()
class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

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
            padding: EdgeInsets.all(pixelRatio * 10),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Settings(),
                ),
                const Align(
                  alignment: Alignment.topCenter,
                  child: Logo(),
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
                  child: Padding(
                    padding: EdgeInsets.only(top: height / 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GameCard(
                          game: Game.matchPairs,
                          path: 'assets/landing/match_pairs.png',
                          shadow: purpleShadow,
                        ),
                        SizedBox(
                          width: width / 15,
                        ),
                        GameCard(
                          game: Game.minesweeper,
                          path: 'assets/landing/minesweeper.png',
                          shadow: redShadow,
                        ),
                      ],
                    ),
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
