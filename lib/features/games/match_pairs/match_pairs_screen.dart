import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/dialogs/loss_match_pairs.dart';
import 'package:lucky_games/features/games/dialogs/out_of_lives.dart';
import 'package:lucky_games/features/games/widgets/coins.dart';
import 'package:lucky_games/features/games/widgets/home.dart';
import 'package:lucky_games/features/games/widgets/lives.dart';
import 'package:lucky_games/features/games/widgets/tries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../router/router.dart';
import '../../landing/landing_screen.dart';
import '../dialogs/victory.dart';
import '../difficulty/difficulty.dart';
import 'match_pairs_bloc.dart';

late List<Picture> pictures;
var selectedPictures;
var selectedIndexes;
var tries;

class Picture {
  final String image;
  var isDisclosed = false;

  Picture(this.image, this.isDisclosed);
}

@RoutePage()
class MatchPairsScreen extends StatefulWidget {
  final Difficulty difficulty;
  final int level;
  const MatchPairsScreen(
      {super.key, required this.difficulty, required this.level});

  @override
  State<MatchPairsScreen> createState() => _MatchPairsScreenState();
}

class _MatchPairsScreenState extends State<MatchPairsScreen>
    with TickerProviderStateMixin {
  late Map<int, AnimationController> _animationControllers = {};
  late Map<int, Animation<double>> _animations = {};
  late Map<int, AnimationStatus> _animationStatuses = {};
  late ConfettiController _confettiController;
  late StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    tries = widget.difficulty.matchPairsNumberOfTries;
    _confettiController =
        ConfettiController(duration: const Duration(milliseconds: 800));
    for (int i = 0; i < getItemCount(widget.level); i++) {
      _animationStatuses[i] = AnimationStatus.dismissed;
      _animationControllers[i] = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
      );
      _animations[i] = CurvedAnimation(
        parent: _animationControllers[i]!,
        curve: Curves.easeOutBack,
      ).drive(Tween<double>(begin: 0, end: 1))
        ..addListener(_handleAnimationListener)
        ..addStatusListener((status) {
          _handleAnimationStatusListener(i, status);
        });
    }
    initializePictures(widget.level);
    _streamSubscription =
        BlocProvider.of<MatchPairsBloc>(context).stream.listen((state) async {
      if (state is ImageMatchState) {
        pictures[state.imgIndex1].isDisclosed = true;
        pictures[state.imgIndex2].isDisclosed = true;
        var isEnd = true;
        for (var picture in pictures) {
          if (!picture.isDisclosed) {
            isEnd = false;
          }
        }
        if (isEnd && mounted) {
          var lives = locator<SharedPreferences>().getInt('lives');
          var coins = locator<SharedPreferences>().getInt('coins');
          await locator<SharedPreferences>().setInt('lives', lives! + 1);
          await locator<SharedPreferences>()
              .setInt('coins', coins! + widget.difficulty.coinsReward);
          List<String>? levels = locator<SharedPreferences>()
              .getStringList('MatchPairs${widget.difficulty.name}');
          if (widget.level != levels!.length) {
            levels[widget.level] = 'unlocked';
            await locator<SharedPreferences>()
                .setStringList('MatchPairs${widget.difficulty.name}', levels);
          }
          showVictoryDialog(
              context, widget.difficulty.colors, widget.difficulty);
          _confettiController.play();
        }
      }
      if (state is ImageMismatchState) {
        _animationControllers[state.imgIndex2]?.forward();
        Future.delayed(const Duration(milliseconds: 500), () async {
          _animationControllers[state.imgIndex1]?.reverse();
          _animationControllers[state.imgIndex2]?.reverse();
          tries--;
          if (tries == 0) {
            var lives = locator<SharedPreferences>().getInt('lives');
            await locator<SharedPreferences>().setInt('lives', lives! - 1);
            showMatchPairsLossDialog(context, widget.difficulty.colors,
                Game.matchPairs, widget.difficulty,
                level: widget.level);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < getItemCount(widget.level); i++) {
      _animationControllers[i]?.removeListener(_handleAnimationListener);
      _animationControllers[i]?.removeStatusListener((status) {
        _handleAnimationStatusListener(i, status);
      });
      _animationControllers[i]?.dispose();
    }
    _animationControllers = {};
    _animations = {};
    _animationStatuses = {};
    _confettiController.dispose();
    _streamSubscription?.cancel();
  }

  void _handleAnimationListener() {
    setState(() {});
  }

  void _handleAnimationStatusListener(int? i, AnimationStatus status) {
    _animationStatuses[i!] = status;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;

    const double spacing = 4;
    const double runSpacing = 4;

    final int listSize = getItemCount(widget.level);
    final columns = getCrossAxisCount(widget.level) + 1;
    final w =
        (width * (widget.level == 5 ? 0.7 : 1) - runSpacing * (columns - 1)) /
            columns;

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
            ),
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
                Row(
                  children: [
                    const Home(),
                    SizedBox(width: 5),
                    Tries(tries: tries),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Match pairs'.toUpperCase(),
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                    const SizedBox(width: 10),
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
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: height,
                    child: Padding(
                      padding: EdgeInsets.only(top: height / 10),
                      child: Center(
                        child: Wrap(
                          runSpacing: runSpacing,
                          spacing: spacing,
                          alignment: WrapAlignment.center,
                          children: List.generate(listSize, (index) {
                            final bloc =
                                BlocProvider.of<MatchPairsBloc>(context);
                            return GestureDetector(
                              onTap: () {
                                // showVictoryDialog(
                                //     context,
                                //     widget.difficulty.colors,
                                //     widget.difficulty);
                                if (_animationStatuses[index] ==
                                        AnimationStatus.dismissed &&
                                    !_animationStatuses.containsValue(
                                        AnimationStatus.reverse)) {
                                  if (!pictures[index].isDisclosed) {
                                    if (!_animationControllers[index]!
                                        .isAnimating) {
                                      _animationControllers[index]?.forward();
                                      bloc.add(ImageSelected(
                                          pictures[index].image, index));
                                    }
                                  } else {
                                    if (!_animationControllers[index]!
                                        .isAnimating) {
                                      _animationControllers[index]?.reverse();
                                    }
                                  }
                                }
                              },
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..setEntry(2, 1, 0.0015)
                                  ..rotateY(pi * _animations[index]!.value),
                                child: _animations[index]!.value <= 0.5
                                    ? Container(
                                        width: w,
                                        height: w,
                                        decoration: BoxDecoration(
                                          boxShadow: const [defaultShadow],
                                          borderRadius:
                                              BorderRadius.circular(5.sp),
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFF39316C),
                                              Color(0xFF251F4F),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '?',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium
                                                ?.copyWith(
                                                    fontSize: 32.5.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromRGBO(
                                                        255, 255, 255, 0.25)),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: w,
                                        height: w,
                                        decoration: BoxDecoration(
                                          boxShadow: [widget.difficulty.shadow],
                                          borderRadius:
                                              BorderRadius.circular(5.sp),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: widget.difficulty.colors,
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                              pictures[index].image),
                                        ),
                                      ),
                              ),
                            );
                          }),
                        ),
                      ),
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

  void initializePictures(int level) {
    var allPictures = List.generate(
        23, (index) => 'assets/match_pairs/image${index + 1}.png');
    selectedIndexes = [];
    selectedPictures = [];
    pictures = [];

    while (selectedPictures.length < getItemCount(level) / 2) {
      var randomIndex = Random().nextInt(allPictures.length);
      if (!selectedIndexes.contains(randomIndex)) {
        selectedPictures.add(allPictures[randomIndex]);
        selectedIndexes.add(randomIndex);
      }
    }
    for (var i = 0; i < getItemCount(level) / 2; i++) {
      pictures.add(Picture(selectedPictures[i], false));
      pictures.add(Picture(selectedPictures[i], false));
    }
    pictures.shuffle();
    for (int i = 0; i < getItemCount(level); i++) {
      _animationControllers[i]?.forward();
      Future.delayed(
          Duration(milliseconds: widget.difficulty.matchPairsShowDuration), () {
        _animationControllers[i]?.reverse();
      });
    }
  }

  getCrossAxisCount(int level) {
    switch (level) {
      case 1:
        return 4;
      case 2:
        return 6;
      case 3:
        return 6;
      default:
        return 8;
    }
  }

  getItemCount(int level) {
    switch (level) {
      case 1:
        return 4;
      case 2:
        return 6;
      case 3:
        return 8;
      case 4:
        return 16;
      case 5:
        return 32;
      default:
    }
  }
}
