import 'package:flutter/material.dart';
import 'package:lucky_games/consts.dart';

enum Difficulty {
  simple(
    'Simple',
    purpleColor,
    [
      Color(0xFF662AFB),
      Color(0xFFC94AF6),
    ],
    50,
    5,
    750,
    purpleShadow,
  ),
  middle(
    'Middle',
    redColor,
    [
      Color(0xFFEE2654),
      Color(0xFFFF80B1),
    ],
    75,
    4,
    1000,
    redShadow,
  ),
  advanced(
    'Advanced',
    orangeColor,
    [
      Color(0xFFFA9B00),
      Color(0xFFF64A4A),
    ],
    100,
    3,
    1250,
    orangeShadow,
  );

  final String name;
  final Color color;
  final List<Color> colors;
  final int coinsReward;
  final int matchPairsNumberOfTries;
  final int matchPairsShowDuration;
  final BoxShadow shadow;

  const Difficulty(this.name, this.color, this.colors, this.coinsReward,
      this.matchPairsNumberOfTries, this.matchPairsShowDuration, this.shadow);
}
