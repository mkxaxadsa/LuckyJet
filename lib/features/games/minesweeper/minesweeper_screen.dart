import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/minesweeper/minesweeper_bloc.dart';
import 'package:lucky_games/features/games/widgets/coins.dart';
import 'package:lucky_games/features/games/widgets/home.dart';
import 'package:lucky_games/features/games/widgets/lives.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoda/yoda.dart';

import '../../../main.dart';
import '../../landing/landing_screen.dart';
import '../dialogs/loss_minesweeper.dart';
import '../dialogs/victory.dart';
import '../difficulty/difficulty.dart';

List<FieldCell> mineField = [];
const isDev = false;

class FieldCell {
  final int id;
  final bool isExcluded;
  var isDisclosed;
  var isBomb;

  FieldCell(this.id, this.isExcluded, this.isDisclosed, this.isBomb);
}

@RoutePage()
class MinesweeperScreen extends StatefulWidget {
  final Difficulty difficulty;

  const MinesweeperScreen({super.key, required this.difficulty});

  @override
  State<MinesweeperScreen> createState() => _MinesweeperScreenState();
}

class _MinesweeperScreenState extends State<MinesweeperScreen>
    with TickerProviderStateMixin {
  late Map<int, AnimationController> _animationControllers = {};
  late Map<int, Animation<double>> _animations = {};
  late ConfettiController _confettiController;
  late YodaController _explosionController;
  late StreamSubscription? _streamSubscription;
  var isEnd = false;

  @override
  void initState() {
    super.initState();
    initialize();
    for (int i = 0; i < mineField.length; i++) {
      if (!mineField[i].isExcluded) {
        _animationControllers[i] = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 250),
        );
        _animations[i] = CurvedAnimation(
          parent: _animationControllers[i]!,
          curve: Curves.easeInOut,
        ).drive(Tween<double>(begin: 1, end: 0.5))
          ..addListener(_handleAnimationListener);
      } else {
        continue;
      }
    }
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
    _explosionController = YodaController();
    _streamSubscription =
        BlocProvider.of<MinesweeperBloc>(context).stream.listen((state) async {
      if (state is CellIsBombState) {
        var lives = locator<SharedPreferences>().getInt('lives');
        await locator<SharedPreferences>().setInt('lives', lives! - 1);
        isEnd = true;
        mineField[state.cell.id].isDisclosed = true;
        Future.delayed(const Duration(milliseconds: 500), () {
          _explosionController.start();
          showMinesweeperLossDialog(context, widget.difficulty.colors,
              Game.minesweeper, widget.difficulty);
        });
      }
      if (state is CellIsNotBombState) {
        mineField[state.cell.id].isDisclosed = true;
        if (mineField.where((element) {
              return element.isDisclosed == false && !element.isExcluded;
            }).length ==
            1) {
          isEnd = true;
          discloseBomb();
          _confettiController.play();
          var lives = locator<SharedPreferences>().getInt('lives');
          var coins = locator<SharedPreferences>().getInt('coins');
          await locator<SharedPreferences>().setInt('lives', lives! + 1);
          await locator<SharedPreferences>()
              .setInt('coins', coins! + widget.difficulty.coinsReward);
          Future.delayed(const Duration(milliseconds: 500), () {
            showVictoryDialog(
                context, widget.difficulty.colors, widget.difficulty);
          });
        }
      }
    });
  }

  void _handleAnimationListener() {
    setState(() {});
  }

  void discloseBomb() {
    for (final cell in mineField) {
      if (cell.isBomb) {
        cell.isDisclosed = true;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < mineField.length; i++) {
      if (!mineField[i].isExcluded) {
        _animationControllers[i]?.removeListener(_handleAnimationListener);
        _animationControllers[i]?.dispose();
      } else {
        continue;
      }
    }
    _confettiController.dispose();
    _streamSubscription?.cancel();
    _animationControllers = {};
    _animations = {};
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;
    final columns = getCrossAxisCount(widget.difficulty);

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
            padding: EdgeInsets.only(top: pixelRatio * 10),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: pi / 2,
                    numberOfParticles: 20,
                    emissionFrequency: 0.5,
                    blastDirectionality: BlastDirectionality.explosive,
                    gravity: 0.3,
                    colors: widget.difficulty.colors,
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Home(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Minesweeper'.toUpperCase(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
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
                Yoda(
                  yodaEffect: YodaEffect.Explosion,
                  controller: _explosionController,
                  animParameters: AnimParameters(
                    hTiles: 10,
                    vTiles: 10,
                    blurPower: 0,
                    gravity: 1,
                    effectPower: 0.8,
                    randomness: 10,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 8),
                      child: SizedBox(
                        width: width /
                            (widget.difficulty == Difficulty.advanced
                                ? 1
                                : (widget.difficulty == Difficulty.middle
                                    ? 2.3
                                    : 3)),
                        height: height / pixelRatio * 4,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            crossAxisCount:
                                getCrossAxisCount(widget.difficulty),
                            mainAxisSpacing: 4,
                            crossAxisSpacing: 4,
                          ),
                          itemCount: mineField.length,
                          itemBuilder: (BuildContext context, int index) {
                            final fieldCell = mineField[index];
                            if (fieldCell.isExcluded == false) {
                              return GestureDetector(
                                onTap: () {
                                  // showMinesweeperLossDialog(
                                  //     context,
                                  //     widget.difficulty.colors,
                                  //     Game.minesweeper,
                                  //     widget.difficulty);
                                  if (!isEnd && !fieldCell.isDisclosed) {
                                    _animationControllers[index]?.forward();
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      _animationControllers[index]?.reverse();
                                    });
                                    BlocProvider.of<MinesweeperBloc>(context)
                                        .add(CellTouched(fieldCell));
                                  }
                                },
                                child: BlocBuilder<MinesweeperBloc,
                                    MinesweeperState>(
                                  builder: (_, state) {
                                    final List<Color> colors;
                                    final List<BoxShadow> shadows;
                                    if (fieldCell.isBomb &&
                                        fieldCell.isDisclosed) {
                                      colors = [
                                        const Color(0xFFEE2654),
                                        const Color(0xFFFF80B1),
                                      ];
                                      shadows = [redShadow];
                                    } else {
                                      colors = [
                                        const Color(0xFF39316C),
                                        const Color(0xFF251F4F),
                                      ];
                                      shadows = [defaultShadow];
                                    }
                                    var theme = Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w700,
                                            color: const Color.fromRGBO(
                                                255, 255, 255, 0.25));
                                    return Transform.scale(
                                      scale: _animations[index]!.value,
                                      child: Container(
                                          decoration: BoxDecoration(
                                            boxShadow: shadows,
                                            borderRadius:
                                                BorderRadius.circular(5.sp),
                                            gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: colors,
                                            ),
                                          ),
                                          child: Center(
                                            child: (fieldCell.isDisclosed
                                                ? fieldCell.isBomb
                                                    ? isEnd &&
                                                            state
                                                                is CellIsNotBombState
                                                        ? Image.asset(
                                                            'assets/minesweeper/bomb.png',
                                                            scale: 0.8,
                                                          )
                                                        : ShakeWidget(
                                                            autoPlay: true,
                                                            shakeConstant:
                                                                ShakeHardConstant1(),
                                                            child: Image.asset(
                                                              'assets/minesweeper/bomb.png',
                                                              scale: 0.8,
                                                            ))
                                                    : Image.asset(
                                                        'assets/minesweeper/success.png',
                                                        scale: 0.8,
                                                      )
                                                : isDev
                                                    ? fieldCell.isBomb
                                                        ? Text('!',
                                                            style: theme)
                                                        : Text('?',
                                                            style: theme)
                                                    : Text('?', style: theme)),
                                          )),
                                    );
                                  },
                                ),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getCrossAxisCount(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.simple:
        return 4;
      case Difficulty.middle:
        return 5;
      case Difficulty.advanced:
        return 10;
      default:
    }
  }

  getItemCount(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.simple:
        return 16;
      case Difficulty.middle:
        return 20;
      case Difficulty.advanced:
        return 40;
      default:
    }
  }

  getExcludedItems(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.simple:
        return [0, 3, 12, 15];
      case Difficulty.middle:
        return [0, 4, 15, 19];
      case Difficulty.advanced:
        return [0, 9, 30, 39];
      default:
    }
  }

  void initialize() {
    mineField.clear();
    final excludedItems = getExcludedItems(widget.difficulty);
    for (var i = 0; i < getItemCount(widget.difficulty); i++) {
      mineField.add(FieldCell(i, excludedItems.contains(i) ? true : false,
          excludedItems.contains(i) ? true : false, false));
    }
    plantBomb();
  }

  void plantBomb() {
    final bombIndex = Random().nextInt(getItemCount(widget.difficulty));
    if (mineField[bombIndex].isExcluded) {
      plantBomb();
    }
    mineField[bombIndex].isBomb = true;
  }
}
