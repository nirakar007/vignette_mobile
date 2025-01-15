import 'package:vignette__mobile/features/board/data/data_source/board_data_source.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

class BoardLocalDataSource implements IBoardDataSource {
  @override
  Future<List<BoardEntity>> createBoard(BoardEntity board) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBoard() {
    throw UnimplementedError();
  }

  @override
  Future<List<BoardEntity>> getBoards() {
    throw UnimplementedError();
  }

  @override
  Future<BoardEntity> updateBoard(BoardEntity board, String boardId) {
    throw UnimplementedError();
  }
}
