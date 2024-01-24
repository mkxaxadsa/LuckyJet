import 'package:flutter/material.dart';
import 'package:lucky_games/features/games/difficulty/difficulty.dart';

class OpaqueContainer extends StatelessWidget {
  final Widget child;
  final Difficulty difficulty;
  const OpaqueContainer(
      {super.key, required this.child, required this.difficulty});
  @override
  Widget build(BuildContext context) {
    var pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return FittedBox(
      child: Container(
        padding: EdgeInsets.all(pixelRatio * 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(pixelRatio * 5),
          ),
          color: Color.fromRGBO(37, 31, 79, 0.2),
        ),
        child: child,
      ),
    );
  }
}
