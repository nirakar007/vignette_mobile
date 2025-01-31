import 'package:dio/dio.dart';
import 'package:vignette__mobile/app/constants/api_endpoints.dart';
import 'package:vignette__mobile/features/board/data/data_source/board_data_source.dart';
import 'package:vignette__mobile/features/board/data/dto/get_all_boards_dto.dart';
import 'package:vignette__mobile/features/board/data/model/board_api_model.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

class BoardRemoteDataSource implements IBoardDataSource {
  final Dio _dio;
  BoardRemoteDataSource(this._dio);

  @override
  Future<void> createBoard(BoardEntity course) async {
    try {
      // Convert entity to model
      var courseApiModel = BoardApiModel.fromEntity(course);
      var response = await _dio.post(
        ApiEndpoints.createBoard,
        data: courseApiModel.toJson(),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteBoard(String boardId) {
    // TODO: implement deleteBoard
    throw UnimplementedError();
  }

  @override
  Future<List<BoardEntity>> getAllBoards() async {
    try {
      var response = await _dio.get(ApiEndpoints.getAllBoards);
      if (response.statusCode == 200) {
        GetAllBoardsDTO courseAddDTO = GetAllBoardsDTO.fromJson(response.data);
        return BoardApiModel.toEntityList(
            courseAddDTO.data.cast<BoardApiModel>());
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<BoardEntity>> getBoard(String boardId) {
    // TODO: implement getBoard
    throw UnimplementedError();
  }

  @override
  Future<BoardEntity> updateBoard(BoardEntity board, String boardId) {
    // TODO: implement updateBoard
    throw UnimplementedError();
  }
}
