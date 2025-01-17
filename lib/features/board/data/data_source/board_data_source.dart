import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

abstract interface class IBoardDataSource {
  Future<List<BoardEntity>> getAllBoards();
  Future<List<BoardEntity>> getBoard(String boardId);
  Future<List<BoardEntity>> createBoard(BoardEntity board);
  Future<void> deleteBoard();
  Future<BoardEntity> updateBoard(BoardEntity board, String boardId);
}
