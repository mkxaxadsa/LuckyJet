import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingPageData {
  final int id;
  final String title;
  final String description;
  final String? imagePath;

  OnboardingPageData(this.id, this.title, this.description, [this.imagePath]);
}

final onboardingPages = [
  OnboardingPageData(
      0,
      'Welcome to the Jet Games Challenge!',
      '🌟 Embark on an exhilarating journey through our mobile game, featuring 5 levels of mind-bending puzzles. Each level offers you the choice of three difficulty options, ensuring that players of all skill levels can find their perfect challenge.',
      'assets/onboarding/1.svg'),
  OnboardingPageData(
      1,
      'Diverse Game Modes Await You! Match Pairs:',
      'Test your memory and observational skills by uncovering matching pairs within the allotted number of attempts.',
      'assets/onboarding/2.png'),
  OnboardingPageData(
      2,
      'Minesweeper:',
      'Engage your strategic thinking as you navigate through a grid, aiming to uncover all safe tiles without hitting the hidden bomb.',
      'assets/onboarding/3.png'),
  OnboardingPageData(
      3,
      'Tailor Your Gaming Experience.',
      'Whether you enjoy testing your memory or prefer a strategic approach, you get to choose the game mode that resonates with you the most.',
      'assets/onboarding/4.png'),
  OnboardingPageData(
    4,
    'Scoring System Breakdown. Earn points based on the difficulty level of each completed stage:',
    'Easy: 50 points\nMedium: 75 points\nHard: 100 points',
    'assets/onboarding/5.png',
  ),
  OnboardingPageData(
      5,
      'Pro Tips for Progression:',
      'To advance to the next level, conquer all three difficulty levels within each stage. Accumulate points to unlock exciting rewards and exclusive achievements.',
      'assets/onboarding/6.1.png'),
  OnboardingPageData(
    6,
    'Embark on Your Puzzle Adventure Now!',
    'Challenge yourself, accumulate points, and uncover the exciting rewards that await you. Best of luck on your puzzle-solving journey! 🚀',
  ),
];

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingPageData> {
  var i = 0;
  OnboardingBloc() : super(onboardingPages.first) {
    on<NextPage>(_nextPage);
  }
  void _nextPage(NextPage event, Emitter<OnboardingPageData> emit) {
    if (i < onboardingPages.length - 1) {
      i++;
      emit(OnboardingPageData(onboardingPages[i].id, onboardingPages[i].title,
          onboardingPages[i].description, onboardingPages[i].imagePath));
    }
  }
}

abstract class OnboardingEvent {}

class NextPage extends OnboardingEvent {}
