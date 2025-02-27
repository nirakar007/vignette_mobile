import 'package:vignette__mobile/core/common/internet_checker/network_info.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';

class BoardRepositoryImpl implements IBoardRepository {
  final BoardLocalRepository localRepository;
  final BoardRemoteRepository remoteRepository;
  final NetworkInfo networkInfo;

  BoardRepositoryImpl({
    required this.localRepository,
    required this.remoteRepository,
    required this.networkInfo,
  });

  @override
  Future<List<BoardEntity>> getBoards(String userId) async {
    try {
      if (await networkInfo.isConnected) {
        final remoteBoards = await remoteRepository.getBoards(userId);
        await _cacheRemoteBoards(remoteBoards);
        return remoteBoards;
      }
      return await localRepository.getBoards(userId);
    } catch (e) {
      return await localRepository.getBoards(userId);
    }
  }

  Future<void> _cacheRemoteBoards(List<BoardEntity> remoteBoards) async {
    for (final board in remoteBoards) {
      await localRepository.updateSyncStatus(board.boardId!, board.boardId!);
    }
  }

  @override
  Future<void> syncData() async {
    if (await networkInfo.isConnected) {
      final unsynced = await localRepository.getUnsyncedBoards();
      for (final board in unsynced) {
        await remoteRepository.getBoards(board.userId);
        await localRepository.updateSyncStatus(board.boardId!, board.boardId!);
      }
    }
  }

  @override
  Future<BoardEntity> getBoardById(String boardId) {
    // TODO: implement getBoardById
    throw UnimplementedError();
  }
  
  @override
  Future<void> createBoard(BoardEntity board) {
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
  Future<void> updateBoard(BoardEntity board) {
    // TODO: implement updateBoard
    throw UnimplementedError();
  }

  // Implement other interface methods with similar network-aware logic
}

class BoardRemoteRepository {
}

class BoardLocalRepository {
}