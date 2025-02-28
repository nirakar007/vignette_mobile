import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

// Main repository interface
abstract class IBoardRepository {
  // Basic CRUD operations
  Future<String> createBoard(BoardEntity board);
  Future<List<BoardEntity>> getBoards(String userId);
  // Future<BoardEntity> getBoardById(String boardId);
  Future<void> updateBoard(BoardEntity board,String boardId);
  Future<void> deleteBoard(String boardId);
  Future<void> toggleFavorite(String boardId, bool isFavorite);

  // Sync operations
  Future<void> syncBoards();
}

// Local-specific repository contract
abstract class BoardLocalRepository implements IBoardRepository {
  // Local storage specific operations
  Future<List<BoardEntity>> getUnsyncedBoards();
  Future<void> updateSyncStatus(String localId, String remoteId);
  Future<void> cacheRemoteBoards(List<BoardEntity> boards);
}

// Remote-specific repository contract
abstract class BoardRemoteRepository implements IBoardRepository {
  // Remote API specific operations
  Future<String?> uploadImage(String localPath);
  Future<void> updateFavoriteStatus(String boardId, bool isFavorite);
  Future<void> syncWithRemote(List<BoardEntity> localBoards);
}
