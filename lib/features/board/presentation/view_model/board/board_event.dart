part of 'board_bloc.dart';

sealed class BoardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CreateBoardEvent extends BoardEvent {
  final BoardEntity board;

  CreateBoardEvent(this.board);

  @override
  List<Object?> get props => [board];
}

class DeleteBoardEvent extends BoardEvent {
  final String boardId;

  DeleteBoardEvent(this.boardId);

  @override
  List<Object?> get props => [boardId];
}

class UpdateBoardEvent extends BoardEvent {
  final BoardEntity board;
  final String boardId;

  UpdateBoardEvent(this.board, this.boardId);

  @override
  List<Object?> get props => [board, boardId];
}

class GetAllBoardsEvent extends BoardEvent {}

class GetBoardEvent extends BoardEvent {
  final String boardId;

  GetBoardEvent(this.boardId);

  @override
  List<Object?> get props => [boardId];
}
