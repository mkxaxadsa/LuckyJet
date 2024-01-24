// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    DifficultyRoute.name: (routeData) {
      final args = routeData.argsAs<DifficultyRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DifficultyScreen(
          key: args.key,
          game: args.game,
        ),
      );
    },
    LandingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LandingScreen(),
      );
    },
    MatchPairsLevelRoute.name: (routeData) {
      final args = routeData.argsAs<MatchPairsLevelRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MatchPairsLevelScreen(
          key: args.key,
          difficulty: args.difficulty,
          colors: args.colors,
        ),
      );
    },
    MatchPairsRoute.name: (routeData) {
      final args = routeData.argsAs<MatchPairsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MatchPairsScreen(
          key: args.key,
          difficulty: args.difficulty,
          level: args.level,
        ),
      );
    },
    MinesweeperRoute.name: (routeData) {
      final args = routeData.argsAs<MinesweeperRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MinesweeperScreen(
          key: args.key,
          difficulty: args.difficulty,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    PrivacyPolicyRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PrivacyPolicyScreen(),
      );
    },
    PurchaseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PurchaseScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    TermsOfUseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TermsOfUseScreen(),
      );
    },
  };
}

/// generated route for
/// [DifficultyScreen]
class DifficultyRoute extends PageRouteInfo<DifficultyRouteArgs> {
  DifficultyRoute({
    Key? key,
    required Game game,
    List<PageRouteInfo>? children,
  }) : super(
          DifficultyRoute.name,
          args: DifficultyRouteArgs(
            key: key,
            game: game,
          ),
          initialChildren: children,
        );

  static const String name = 'DifficultyRoute';

  static const PageInfo<DifficultyRouteArgs> page =
      PageInfo<DifficultyRouteArgs>(name);
}

class DifficultyRouteArgs {
  const DifficultyRouteArgs({
    this.key,
    required this.game,
  });

  final Key? key;

  final Game game;

  @override
  String toString() {
    return 'DifficultyRouteArgs{key: $key, game: $game}';
  }
}

/// generated route for
/// [LandingScreen]
class LandingRoute extends PageRouteInfo<void> {
  const LandingRoute({List<PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MatchPairsLevelScreen]
class MatchPairsLevelRoute extends PageRouteInfo<MatchPairsLevelRouteArgs> {
  MatchPairsLevelRoute({
    Key? key,
    required Difficulty difficulty,
    required List<Color> colors,
    List<PageRouteInfo>? children,
  }) : super(
          MatchPairsLevelRoute.name,
          args: MatchPairsLevelRouteArgs(
            key: key,
            difficulty: difficulty,
            colors: colors,
          ),
          initialChildren: children,
        );

  static const String name = 'MatchPairsLevelRoute';

  static const PageInfo<MatchPairsLevelRouteArgs> page =
      PageInfo<MatchPairsLevelRouteArgs>(name);
}

class MatchPairsLevelRouteArgs {
  const MatchPairsLevelRouteArgs({
    this.key,
    required this.difficulty,
    required this.colors,
  });

  final Key? key;

  final Difficulty difficulty;

  final List<Color> colors;

  @override
  String toString() {
    return 'MatchPairsLevelRouteArgs{key: $key, difficulty: $difficulty, colors: $colors}';
  }
}

/// generated route for
/// [MatchPairsScreen]
class MatchPairsRoute extends PageRouteInfo<MatchPairsRouteArgs> {
  MatchPairsRoute({
    Key? key,
    required Difficulty difficulty,
    required int level,
    List<PageRouteInfo>? children,
  }) : super(
          MatchPairsRoute.name,
          args: MatchPairsRouteArgs(
            key: key,
            difficulty: difficulty,
            level: level,
          ),
          initialChildren: children,
        );

  static const String name = 'MatchPairsRoute';

  static const PageInfo<MatchPairsRouteArgs> page =
      PageInfo<MatchPairsRouteArgs>(name);
}

class MatchPairsRouteArgs {
  const MatchPairsRouteArgs({
    this.key,
    required this.difficulty,
    required this.level,
  });

  final Key? key;

  final Difficulty difficulty;

  final int level;

  @override
  String toString() {
    return 'MatchPairsRouteArgs{key: $key, difficulty: $difficulty, level: $level}';
  }
}

/// generated route for
/// [MinesweeperScreen]
class MinesweeperRoute extends PageRouteInfo<MinesweeperRouteArgs> {
  MinesweeperRoute({
    Key? key,
    required Difficulty difficulty,
    List<PageRouteInfo>? children,
  }) : super(
          MinesweeperRoute.name,
          args: MinesweeperRouteArgs(
            key: key,
            difficulty: difficulty,
          ),
          initialChildren: children,
        );

  static const String name = 'MinesweeperRoute';

  static const PageInfo<MinesweeperRouteArgs> page =
      PageInfo<MinesweeperRouteArgs>(name);
}

class MinesweeperRouteArgs {
  const MinesweeperRouteArgs({
    this.key,
    required this.difficulty,
  });

  final Key? key;

  final Difficulty difficulty;

  @override
  String toString() {
    return 'MinesweeperRouteArgs{key: $key, difficulty: $difficulty}';
  }
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PrivacyPolicyScreen]
class PrivacyPolicyRoute extends PageRouteInfo<void> {
  const PrivacyPolicyRoute({List<PageRouteInfo>? children})
      : super(
          PrivacyPolicyRoute.name,
          initialChildren: children,
        );

  static const String name = 'PrivacyPolicyRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PurchaseScreen]
class PurchaseRoute extends PageRouteInfo<void> {
  const PurchaseRoute({List<PageRouteInfo>? children})
      : super(
          PurchaseRoute.name,
          initialChildren: children,
        );

  static const String name = 'PurchaseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TermsOfUseScreen]
class TermsOfUseRoute extends PageRouteInfo<void> {
  const TermsOfUseRoute({List<PageRouteInfo>? children})
      : super(
          TermsOfUseRoute.name,
          initialChildren: children,
        );

  static const String name = 'TermsOfUseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
