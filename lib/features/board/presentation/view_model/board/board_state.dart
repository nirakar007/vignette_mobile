part of 'board_bloc.dart';

abstract class BoardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BoardInitialState extends BoardState {}

class BoardLoadingState extends BoardState {}

class BoardSuccessState extends BoardState {
  final List<BoardEntity> boards;

  BoardSuccessState(this.boards);

  @override
  List<Object?> get props => [boards];
}

class BoardLoadedState extends BoardState {
  final BoardEntity board;

  BoardLoadedState(this.board);

  @override
  List<Object?> get props => [board];
}

class BoardErrorState extends BoardState {
  final String message;

  BoardErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
