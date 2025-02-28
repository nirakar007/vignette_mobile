import 'package:vignette__mobile/core/common/internet_checker/network_exception.dart';
import 'package:vignette__mobile/core/common/internet_checker/network_info.dart';
import 'package:vignette__mobile/features/board/data/data_source/remote_data_source/board_remote_data_source.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';

class BoardRemoteRepositoryImpl implements BoardRemoteRepository {
  final BoardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BoardRemoteRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<String> createBoard(BoardEntity board) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    try {
      return await remoteDataSource.createBoard(board);
    } catch (e) {
      throw Exception('Failed to create board: $e');
    }
  }

  @override
  Future<void> deleteBoard(String boardId) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    try {
      await remoteDataSource.deleteBoard(boardId);
    } catch (e) {
      throw Exception('Failed to delete board: $e');
    }
  }

  @override
  Future<void> updateBoard(BoardEntity board, String boardId) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    try {
      await remoteDataSource.updateBoard(board, boardId);
    } catch (e) {
      throw Exception('Failed to update board: $e');
    }
  }

  @override
  Future<void> syncWithRemote(List<BoardEntity> localBoards) async {
    if (!await networkInfo.isConnected) return;

    for (final board in localBoards) {
      try {
        if (board.boardId?.startsWith('local_') ?? false) {
          final remoteId = await createBoard(board);
          await remoteDataSource.updateLocalIdMapping(board.boardId!, remoteId);
        } else {
          await updateBoard(board, board.boardId ?? '');
        }
      } catch (e) {
        // Log error but continue syncing other boards
        print('Sync error for board ${board.boardId}: $e');
      }
    }
  }

  @override
  Future<List<BoardEntity>> getBoards(String userId) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    try {
      return await remoteDataSource.getBoards(userId);
    } catch (e) {
      throw Exception('Failed to fetch boards: $e');
    }
  }

  @override
  Future<BoardEntity> getBoardById(String boardId) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    try {
      return await remoteDataSource.getBoard(boardId);
    } catch (e) {
      throw Exception('Failed to fetch board: $e');
    }
  }

  @override
  Future<String?> uploadImage(String localPath) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    try {
      await remoteDataSource.uploadImage(localPath);
      return 'Image Uploaded';
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  @override
  Future<void> updateFavoriteStatus(String boardId, bool isFavorite) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    try {
      await remoteDataSource.updateFavoriteStatus(boardId, isFavorite);
    } catch (e) {
      throw Exception('Failed to update favorite status: $e');
    }
  }

  @override
  Future<void> syncData() async {
    if (!await networkInfo.isConnected) return;
    try {
      await remoteDataSource.syncBoards();
    } catch (e) {
      throw Exception('Failed to sync data: $e');
    }
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
}
