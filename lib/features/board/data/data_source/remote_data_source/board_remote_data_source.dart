import 'package:dio/dio.dart';
import 'package:vignette__mobile/app/constants/api_endpoints.dart';
import 'package:vignette__mobile/features/board/data/data_source/board_data_source.dart';
import 'package:vignette__mobile/features/board/data/model/board_api_model.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

class BoardRemoteDataSource implements IBoardDataSource {
  final Dio _dio;

  BoardRemoteDataSource(this._dio);

  @override
  Future<String> createBoard(BoardEntity board) async {
    try {
      final response = await _dio.post(ApiEndpoints.createBoard, data: board);

      if (response.statusCode == 201) {
        return _parseBoardId(response.data);
      }
      throw _createDioException(response);
    } on DioException catch (e) {
      throw Exception('Create board failed: ${e.message}');
    }
  }

  @override
  Future<void> deleteBoard(String boardId) async {
    try {
      final response = await _dio.delete(
        '${ApiEndpoints.deleteBoard}/$boardId',
      );

      if (response.statusCode != 204) {
        throw _createDioException(response);
      }
    } on DioException catch (e) {
      throw Exception('Delete board failed: ${e.message}');
    }
  }

  Future<List<BoardEntity>> getBoards(String userId) async {
    try {
      final response = await _dio.get(
        ApiEndpoints.getAllBoards,
        queryParameters: {'userId': userId},
      );
      return _parseBoardResponse(response);
    } on DioException catch (e) {
      throw Exception('Get boards failed: ${e.message}');
    }
  }

  @override
  Future<BoardEntity> getBoard(String boardId) async {
    try {
      final response = await _dio.get(
        '${ApiEndpoints.getBoard}/$boardId',
      );
      return _parseSingleBoard(response);
    } on DioException catch (e) {
      throw Exception('Get board failed: ${e.message}');
    }
  }

  @override
  Future<BoardEntity> updateBoard(BoardEntity board, String boardId) async {
    try {
      final boardModel = BoardApiModel.fromEntity(board);
      final response = await _dio.put(
        '${ApiEndpoints.updateBoard}/$boardId',
        data: board,
      );
      return _parseSingleBoard(response);
    } on DioException catch (e) {
      throw Exception('Update board failed: ${e.message}');
    }
  }

  Future<void> uploadImage(String localPath) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(localPath),
      });

      await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );
    } on DioException catch (e) {
      throw Exception('Image upload failed: ${e.message}');
    }
  }

  Future<void> updateFavoriteStatus(String boardId, bool isFavorite) async {
    try {
      await _dio.patch(
        '${ApiEndpoints.toggleFavorite}/$boardId/favorite',
        data: {'isFavorite': isFavorite},
      );
    } on DioException catch (e) {
      throw Exception('Favorite update failed: ${e.message}');
    }
  }

  Future<void> updateLocalIdMapping(String localId, String remoteId) async {
    // Implement if your backend needs ID mapping
  }

  // Helper methods
  List<BoardEntity> _parseBoardResponse(Response response) {
    if (response.statusCode != 200) throw _createDioException(response);
    final data = response.data as List;
    return data.map((json) => BoardApiModel.fromJson(json).toEntity()).toList();
  }

  BoardEntity _parseSingleBoard(Response response) {
    if (response.statusCode != 200) throw _createDioException(response);
    return BoardApiModel.fromJson(response.data).toEntity();
  }

  String _parseBoardId(Map<String, dynamic> responseData) {
    return responseData['data']['boardId'] as String;
  }

  DioException _createDioException(Response response) {
    return DioException(
      requestOptions: response.requestOptions,
      response: response,
      error: 'API Error: ${response.statusCode} - ${response.statusMessage}',
    );
  }

  syncBoards() {}

  @override
  Future<List<BoardEntity>> getAllBoards() {
    // TODO: implement getAllBoards
    throw UnimplementedError();
  }
}
