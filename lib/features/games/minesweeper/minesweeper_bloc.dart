import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucky_games/features/games/minesweeper/minesweeper_screen.dart';

class MinesweeperBloc extends Bloc<MinesweeperEvent, MinesweeperState> {
  MinesweeperBloc() : super(InitialState()) {
    on<InitialEvent>(_initialize);
    on<CellTouched>(_cellTouched);
  }
  void _initialize(MinesweeperEvent event, Emitter<MinesweeperState> emit) {
    emit(InitialState());
  }

  void _cellTouched(CellTouched event, Emitter<MinesweeperState> emit) {
    if (event.cell.isBomb) {
      emit(CellIsBombState(event.cell));
    } else {
      emit(CellIsNotBombState(event.cell));
    }
  }
}

abstract class MinesweeperEvent {}

class InitialEvent extends MinesweeperEvent {}

class CellTouched extends MinesweeperEvent {
  final FieldCell cell;

  CellTouched(this.cell);
}

abstract class MinesweeperState {}

class InitialState extends MinesweeperState {}

class CellTouchedState extends MinesweeperState {
  final FieldCell cell;

  CellTouchedState(this.cell);
}

class CellIsBombState extends MinesweeperState {
  final FieldCell cell;

  CellIsBombState(this.cell);
}

class CellIsNotBombState extends MinesweeperState {
  final FieldCell cell;

  CellIsNotBombState(this.cell);
}
