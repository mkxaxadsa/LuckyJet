import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucky_games/consts.dart';
import 'package:lucky_games/features/games/widgets/logo.dart';
import 'package:lucky_games/features/games/widgets/onboarding_logo.dart';
import 'package:lucky_games/router/router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'onboarding_bloc.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _glareAnimationController;
  late AnimationController _infoAnimationController;
  late AnimationController _fadeAnimationController;

  late Animation<Offset> _logoAnimation;
  late Animation<Offset> _glareAnimation;
  late Animation<Offset> _infoAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _glareAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _infoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    final curvedLogoAnimation = CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOutQuart,
    );
    final curvedGlareAnimation = CurvedAnimation(
      parent: _glareAnimationController,
      curve: Curves.easeOutCirc,
    );
    final curvedInfoAnimation = CurvedAnimation(
      parent: _infoAnimationController,
      curve: Curves.easeInOutQuart,
    );
    _logoAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, 0.4),
    ).animate(curvedLogoAnimation);
    Future.delayed(const Duration(milliseconds: 1000), () {
      _logoAnimationController.forward();
    });
    _infoAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: const Offset(0, -0.25),
    ).animate(curvedInfoAnimation);
    Future.delayed(const Duration(milliseconds: 1000), () {
      _infoAnimationController.forward();
    });
    _glareAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 0),
    ).animate(curvedGlareAnimation);
    Future.delayed(const Duration(milliseconds: 1500), () {
      _glareAnimationController.forward();
    });

    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_fadeAnimationController);
    _fadeAnimationController.forward();
  }

  @override
  void dispose() {
    _infoAnimationController.dispose();
    _glareAnimationController.dispose();
    _logoAnimationController.dispose();
    _fadeAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg/bg1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SlideTransition(
                position: _glareAnimation,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                      ],
                      stops: const [0.1, 1.0],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/bg/glare.png'),
                        fit: BoxFit.cover,
                        // opacity: _glareAnimationController.value,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: BlocBuilder<OnboardingBloc, OnboardingPageData>(
                  builder: (context, state) {
                    if (state.id == 0) {
                      return SlideTransition(
                        position: _logoAnimation,
                        child: const OnboardingLogo(),
                      );
                    } else if (state.id == onboardingPages.length - 1) {
                      return Padding(
                        padding: EdgeInsets.only(top: height / 5),
                        child: GestureDetector(
                          onTap: () async {
                            locator<SharedPreferences>()
                                .setBool('isFirstTime', false);
                            context.router.replaceAll([const LandingRoute()]);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width / 2,
                            height: height / 7,
                            decoration: BoxDecoration(
                              boxShadow: const [purpleShadow],
                              borderRadius: BorderRadius.all(
                                Radius.circular(pixelRatio * 3.5),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF662AFB),
                                  Color(0xFFC94AF6),
                                ],
                                stops: [0, 1],
                              ),
                            ),
                            child: Text(
                              'START GAME',
                              style: textTheme.displayLarge?.copyWith(
                                  fontSize: 13.sp, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      );
                    } else if (state.id == 5) {
                      return Image.asset(
                        state.imagePath!,
                        width: width / 1.5,
                        height: height / 1.5,
                      );
                    } else {
                      return Image.asset(
                        state.imagePath!,
                        width: width / 2.5,
                        height: height / 2.5,
                        scale: 0.1,
                      );
                    }
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _infoAnimation,
                child: Container(
                  width: width / 1.25,
                  height: height / 2.25,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: Offset(-width / 40, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: darkblueColor,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(pixelRatio * 5))),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Transform.translate(
                          offset: Offset(width / 20, -height / 20),
                          child: Container(
                            width: width / 5,
                            height: height / 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(pixelRatio * 3.5)),
                              color: orangeColor,
                            ),
                            child: Center(
                              child: FittedBox(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width / 35),
                                  child: Text(
                                    'Jet Games Boss',
                                    style: textTheme.displayLarge
                                        ?.copyWith(fontSize: 8.sp),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: width / 25,
                            right: width / 10,
                            top: width / 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<OnboardingBloc, OnboardingPageData>(
                              builder: (context, state) {
                                return FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Text(
                                    state.title,
                                    style: textTheme.displayMedium
                                        ?.copyWith(fontSize: 7.5.sp),
                                  ),
                                );
                              },
                            ),
                            BlocBuilder<OnboardingBloc, OnboardingPageData>(
                              builder: (context, state) {
                                return FadeTransition(
                                  opacity: _fadeAnimation,
                                  child: Text(
                                    state.description,
                                    style: textTheme.displaySmall
                                        ?.copyWith(fontSize: 7.5.sp),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<OnboardingBloc, OnboardingPageData>(
                        builder: (context, state) {
                          if (state.id != onboardingPages.length - 1) {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  if (context.read<OnboardingBloc>().state.id !=
                                      onboardingPages.length - 1) {
                                    _fadeAnimationController.reset();
                                    _fadeAnimationController.forward();
                                  }
                                  context
                                      .read<OnboardingBloc>()
                                      .add(NextPage());
                                },
                                child: Container(
                                  width: width / 14,
                                  height: height / 4,
                                  decoration: BoxDecoration(
                                    boxShadow: const [purpleShadow],
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(pixelRatio * 3.5)),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF662AFB),
                                        Color(0xFFC94AF6),
                                      ],
                                      stops: [0, 1],
                                      transform: GradientRotation(
                                          123.07 * (3.141592653589793 / 180)),
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/onboarding/arrow.svg',
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
