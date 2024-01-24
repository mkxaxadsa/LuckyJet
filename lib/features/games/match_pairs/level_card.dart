import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/main.dart';
import 'package:lucky_games/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dialogs/out_of_lives.dart';
import '../difficulty/difficulty.dart';

class LevelCard extends StatefulWidget {
  final Difficulty difficulty;
  final int id;
  final bool isLocked;
  const LevelCard({
    super.key,
    required this.difficulty,
    required this.id,
    required this.isLocked,
  });

  @override
  State<LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends State<LevelCard> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: width / 7,
      height: height / 1.8,
      decoration: BoxDecoration(
        boxShadow: [widget.difficulty.shadow],
        borderRadius: BorderRadius.all(
          Radius.circular(pixelRatio * 5),
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
          Text(
            widget.id.toString(),
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w800,
                ),
          ),
          SizedBox(height: height / 10),
          GestureDetector(
            onTap: () {
              if (locator<SharedPreferences>().getInt('lives') != 0) {
                if (locator<SharedPreferences>().getStringList(
                            'MatchPairs${widget.difficulty.name}')?[
                        widget.id - 1] ==
                    'unlocked') {
                  context.router.replaceAll([
                    MatchPairsRoute(
                        difficulty: widget.difficulty, level: widget.id)
                  ]);
                }
              } else {
                showOutOfLivesDialog(context, widget.difficulty);
              }
            },
            child: widget.isLocked
                ? Image.asset('assets/difficulty/lock.png')
                : Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: orangeColor,
                    ),
                    child: SvgPicture.asset('assets/onboarding/arrow.svg'),
                  ),
          )
        ],
      ),
    );
  }
}
