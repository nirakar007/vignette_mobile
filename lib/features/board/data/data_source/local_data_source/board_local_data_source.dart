import 'package:vignette__mobile/core/network/hive_service.dart';
import 'package:vignette__mobile/features/board/data/data_source/board_data_source.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

class BoardLocalDataSource implements IBoardDataSource {
  BoardLocalDataSource(HiveService hiveService);

  @override
  Future<List<BoardEntity>> createBoard(BoardEntity board) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBoard(String boardId) {
    throw UnimplementedError();
  }

  @override
  Future<BoardEntity> updateBoard(BoardEntity board, String boardId) {
    throw UnimplementedError();
  }

  @override
  Future<List<BoardEntity>> getAllBoards() {
    throw UnimplementedError();
  }

  @override
  Future<List<BoardEntity>> getBoard(String boardId) {
    throw UnimplementedError();
  }
}
