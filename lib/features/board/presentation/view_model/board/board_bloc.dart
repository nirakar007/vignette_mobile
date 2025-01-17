import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vignette__mobile/features/board/data/data_source/board_data_source.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

part 'board_event.dart';
part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final IBoardDataSource dataSource;

  BoardBloc(this.dataSource) : super(BoardInitialState()) {
    on<CreateBoardEvent>(_onCreateBoard);
    on<DeleteBoardEvent>(_onDeleteBoard);
    on<UpdateBoardEvent>(_onUpdateBoard);
    on<GetAllBoardsEvent>(_onGetAllBoards);
    on<GetBoardEvent>(_onGetBoard);
  }

  Future<void> _onCreateBoard(CreateBoardEvent event, Emitter<BoardState> emit) async {
    emit(BoardLoadingState());
    try {
      final boards = await dataSource.createBoard(event.board);
      emit(BoardSuccessState(boards));
    } catch (e) {
      emit(BoardErrorState(e.toString()));
    }
  }

  Future<void> _onDeleteBoard(DeleteBoardEvent event, Emitter<BoardState> emit) async {
    emit(BoardLoadingState());
    try {
      await dataSource.deleteBoard();
      emit(BoardSuccessState([])); // Assume deletion resets the board list
    } catch (e) {
      emit(BoardErrorState(e.toString()));
    }
  }

  Future<void> _onUpdateBoard(UpdateBoardEvent event, Emitter<BoardState> emit) async {
    emit(BoardLoadingState());
    try {
      final board = await dataSource.updateBoard(event.board, event.boardId);
      emit(BoardLoadedState(board));
    } catch (e) {
      emit(BoardErrorState(e.toString()));
    }
  }

  Future<void> _onGetAllBoards(GetAllBoardsEvent event, Emitter<BoardState> emit) async {
    emit(BoardLoadingState());
    try {
      final boards = await dataSource.getAllBoards();
      emit(BoardSuccessState(boards));
    } catch (e) {
      emit(BoardErrorState(e.toString()));
    }
  }

  Future<void> _onGetBoard(GetBoardEvent event, Emitter<BoardState> emit) async {
    emit(BoardLoadingState());
    try {
      final board = await dataSource.getBoard(event.boardId);
      emit(BoardLoadedState(board.first)); // Assuming the method returns a list with one element
    } catch (e) {
      emit(BoardErrorState(e.toString()));
    }
  }
}
