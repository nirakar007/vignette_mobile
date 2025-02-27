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
  Future<List<BoardEntity>> getBoards(String userId) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    return await remoteDataSource.getBoards(userId);
  }

  @override
  Future<BoardEntity> getBoardById(String boardId) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    return await remoteDataSource.getBoardById(boardId);
  }

  @override
  Future<void> uploadImage(String localPath) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    await remoteDataSource.uploadImage(localPath);
  }

  @override
  Future<void> updateFavoriteStatus(String boardId, bool isFavorite) async {
    if (!await networkInfo.isConnected) throw const NetworkException();
    await remoteDataSource.updateFavoriteStatus(boardId, isFavorite);
  }

  @override
  Future<void> syncData() async {
    // Remote-specific sync logic
  }
}
