import 'package:vignette__mobile/features/board/data/data_source/local_data_source/board_local_data_source.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';

class BoardLocalRepositoryImpl implements BoardLocalRepository {
  final BoardLocalDataSource localDataSource;

  BoardLocalRepositoryImpl({required this.localDataSource});

  @override
  Future<List<BoardEntity>> getBoards(String userId) async {
    return await localDataSource.getBoards(userId);
  }

  @override
  Future<List<BoardEntity>> getUnsyncedBoards() async {
    return await localDataSource.getUnsyncedBoards();
  }

  @override
  Future<void> updateSyncStatus(String localId, String remoteId) async {}

  @override
  Future<void> syncData() async {
    // Local-specific sync logic
  }

  @override
  Future<void> cacheRemoteBoards(List<BoardEntity> boards) {
    // TODO: implement cacheRemoteBoards
    throw UnimplementedError();
  }

  @override
  Future<String> createBoard(BoardEntity board) {
    // TODO: implement createBoard
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBoard(String boardId) {
    // TODO: implement deleteBoard
    throw UnimplementedError();
  }

  @override
  Future<void> syncBoards() {
    // TODO: implement syncBoards
    throw UnimplementedError();
  }

  @override
  Future<void> toggleFavorite(String boardId, bool isFavorite) {
    // TODO: implement toggleFavorite
    throw UnimplementedError();
  }

  @override
  Future<void> updateBoard(BoardEntity board, String boardId) {
    // TODO: implement updateBoard
    throw UnimplementedError();
  }
}
