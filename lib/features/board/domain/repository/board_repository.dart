import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

abstract class IBoardRepository {
  Future<List<BoardEntity>> getBoards(String userId);
  Future<void> createBoard(BoardEntity board);
  Future<void> updateBoard(BoardEntity board);
  Future<void> deleteBoard(String boardId);
  Future<void> syncBoards();
  Future<void> toggleFavorite(String boardId, bool isFavorite);
}
