import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:lucky_games/main.dart';

import '../features/games/difficulty/difficulty.dart';
import '../features/games/difficulty/difficulty_screen.dart';
import '../features/games/match_pairs/level_screen.dart';
import '../features/games/match_pairs/match_pairs_screen.dart';
import '../features/games/minesweeper/minesweeper_screen.dart';
import '../features/landing/landing_screen.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/settings/privacy_policy_screen.dart';
import '../features/settings/purchase_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/settings/terms_of_use_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page, initial: isFirstTime!),
        AutoRoute(page: LandingRoute.page, initial: !isFirstTime!),
        AutoRoute(page: MatchPairsRoute.page),
        AutoRoute(page: MatchPairsLevelRoute.page),
        AutoRoute(page: MinesweeperRoute.page),
        AutoRoute(page: DifficultyRoute.page),
        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: TermsOfUseRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
        AutoRoute(page: PurchaseRoute.page),
      ];
}
