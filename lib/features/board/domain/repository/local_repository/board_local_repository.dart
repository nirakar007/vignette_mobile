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
  Future<BoardEntity> getBoardById(String boardId) async {
    return await localDataSource.getBoardById(boardId);
  }

  @override
  Future<List<BoardEntity>> getUnsyncedBoards() async {
    return await localDataSource.getUnsyncedBoards();
  }

  @override
  Future<void> updateSyncStatus(String localId, String remoteId) async {
    await localDataSource.updateSyncStatus(localId, remoteId);
  }

  @override
  Future<void> syncData() async {
    // Local-specific sync logic
  }
}