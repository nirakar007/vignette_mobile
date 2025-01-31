import 'package:dartz/dartz.dart';
import 'package:vignette__mobile/core/error/failure.dart';
import 'package:vignette__mobile/features/board/data/data_source/remote_data_source/board_remote_data_source.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';
import 'package:vignette__mobile/features/board/domain/repository/board_repository.dart';


class BoardRemoteRepository implements IBoardRepository {
  final BoardRemoteDataSource _boardRemoteDataSource;

  BoardRemoteRepository( this._boardRemoteDataSource);



  @override
  Future<Either<Failure, void>> createBoard(BoardEntity board) async {
    try {
      await _boardRemoteDataSource.createBoard(board);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBoard(String id) {
    // TODO: implement deleteCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BoardEntity>>> getAllBoards() {
    // TODO: implement getCourses
    throw UnimplementedError();
  }
}
