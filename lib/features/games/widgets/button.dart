import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/difficulty/difficulty.dart';

class Button extends StatelessWidget {
  final String text;
  final Difficulty? difficulty;
  final Function(dynamic) callback;
  const Button(
      {super.key, required this.text, required this.callback, this.difficulty});

  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return GestureDetector(
      onTap: () => callback('Argument'),
      child: Container(
        padding: EdgeInsets.all(pixelRatio * 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(pixelRatio * 5),
          ),
          color: difficulty?.color ?? orangeColor,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(fontSize: 7.5.sp, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
