import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/games/match_pairs/match_pairs_bloc.dart';
import 'features/games/minesweeper/minesweeper_bloc.dart';
import 'features/onboarding/onboarding_bloc.dart';
import 'router/router.dart';
import 'theme.dart';

bool? isFirstTime;
final locator = GetIt.instance;

Future<void> initGame() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // await locator<SharedPreferences>().clear();

  isFirstTime = locator<SharedPreferences>().getBool('isFirstTime');
  if (isFirstTime == null) {
    isFirstTime = true;
  } else {
    isFirstTime = false;
  }
  if (isFirstTime!) {
    await locator<SharedPreferences>().setInt('lives', 5);
    await locator<SharedPreferences>().setInt('coins', 1000);
    await locator<SharedPreferences>().setStringList('MatchPairsSimple', [
      'unlocked',
      'locked',
      'locked',
      'locked',
      'locked',
    ]);
    await locator<SharedPreferences>().setStringList('MatchPairsMiddle', [
      'unlocked',
      'locked',
      'locked',
      'locked',
      'locked',
    ]);
    await locator<SharedPreferences>().setStringList('MatchPairsAdvanced', [
      'unlocked',
      'locked',
      'locked',
      'locked',
      'locked',
    ]);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  await initGame();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OnboardingBloc(),
        ),
        BlocProvider(
          create: (context) => MatchPairsBloc(),
        ),
        BlocProvider(
          create: (context) => MinesweeperBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          ScreenUtil.init(context);

          return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: MaterialApp.router(
                theme: themeData,
                debugShowCheckedModeBanner: false,
                routerConfig: appRouter.config(),
              ));
        },
      ),
    );
  }
}
