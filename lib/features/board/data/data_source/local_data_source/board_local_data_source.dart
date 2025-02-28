import 'package:hive/hive.dart';
import 'package:vignette__mobile/features/board/data/model/board_hive_model.dart';
// import 'package:vignette__mobile/features/board/data/model/board_item_hive_model.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

abstract class BoardLocalDataSource {
  BoardLocalDataSource(Object object);

  Future<List<BoardEntity>> getBoards(String userId);
  Future<void> cacheBoards(List<BoardEntity> boards);
  Future<List<BoardEntity>> getUnsyncedBoards();
}

class BoardLocalDataSourceImpl implements BoardLocalDataSource {
  final HiveInterface hive;
  static const String _boxName = 'boards';

  BoardLocalDataSourceImpl(this.hive);

  @override
  Future<List<BoardEntity>> getBoards(String userId) async {
    final box = await hive.openBox<BoardHiveModel>(_boxName);
    final boards = box.values
        .where((model) => model.userId == userId)
        .map(_convertToEntity)
        .toList();
    return boards;
  }

  @override
  Future<void> cacheBoards(List<BoardEntity> boards) async {
    final box = await hive.openBox<BoardHiveModel>(_boxName);
    await box.addAll(boards.map(_convertToModel));
  }

  @override
  Future<List<BoardEntity>> getUnsyncedBoards() async {
    final box = await hive.openBox<BoardHiveModel>(_boxName);
    return box.values
        .where((model) => !model.isSynced)
        .map(_convertToEntity)
        .toList();
  }

  BoardHiveModel _convertToModel(BoardEntity entity) => BoardHiveModel(
        boardId: entity.boardId,
        boardName: entity.boardName,
        userId: entity.userId,
        items: entity.items,
        isFavorite: entity.isFavorite,
        isSynced: entity.isSynced,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  BoardEntity _convertToEntity(BoardHiveModel model) => BoardEntity(
        boardId: model.boardId,
        boardName: model.boardName,
        userId: model.userId!,
        items: model.items,
        isFavorite: model.isFavorite,
        isSynced: model.isSynced,
        createdAt: model.createdAt,
        updatedAt: model.updatedAt,
      );

  BoardHiveModel _convertItemToModel(BoardEntity entity) => BoardHiveModel(
      boardName: entity.boardName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isSynced: entity.isSynced,
      isFavorite: entity.isFavorite);
  BoardEntity _convertItemToEntity(BoardHiveModel model) => BoardEntity(
      boardName: model.boardName,
      userId: model.userId ?? '',
      createdAt: model.createdAt,
      updatedAt: model.updatedAt);
  // Add similar conversion methods for BoardItem
}
