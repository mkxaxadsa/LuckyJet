import 'package:flutter_bloc/flutter_bloc.dart';

class MatchPairsBloc extends Bloc<MatchPairsEvent, MatchPairsState> {
  MatchPairsBloc() : super(InitialState()) {
    on<InitialEvent>(_initialize);
    on<ImageSelected>(_imageSelected);
  }
  void _initialize(MatchPairsEvent event, Emitter<MatchPairsState> emit) {
    emit(InitialState());
  }

  void _imageSelected(ImageSelected event, Emitter<MatchPairsState> emit) {
    if (state is ImageSelectedState) {
      final currentState = state as ImageSelectedState;
      if (currentState.image == event.image &&
          currentState.index != event.index) {
        emit(ImageMatchState(currentState.index, event.index));
      } else {
        emit(ImageMismatchState(currentState.index, event.index));
      }
    } else {
      emit(ImageSelectedState(event.image, event.index));
    }
  }
}

abstract class MatchPairsEvent {}

class InitialEvent extends MatchPairsEvent {}

class ImageSelected extends MatchPairsEvent {
  final String image;
  final int index;

  ImageSelected(this.image, this.index);
}

abstract class MatchPairsState {}

class InitialState extends MatchPairsState {}

class ImageSelectedState extends MatchPairsState {
  final String image;
  final int index;

  ImageSelectedState(this.image, this.index);
}

class ImageMatchState extends MatchPairsState {
  final int imgIndex1;
  final int imgIndex2;

  ImageMatchState(this.imgIndex1, this.imgIndex2);
}

class ImageMismatchState extends MatchPairsState {
  final int imgIndex1;
  final int imgIndex2;

  ImageMismatchState(this.imgIndex1, this.imgIndex2);
}
