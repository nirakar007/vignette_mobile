import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

abstract interface class IBoardDataSource {
  Future<List<BoardEntity>> getAllBoards();
  Future<BoardEntity> getBoard(String boardId);
  Future<void> createBoard(BoardEntity board);
  Future<void> deleteBoard(String boardId);
  Future<BoardEntity> updateBoard(BoardEntity board, String boardId);
}
