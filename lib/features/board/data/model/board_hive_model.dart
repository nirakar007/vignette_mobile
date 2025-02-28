import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:vignette__mobile/features/board/data/model/board_item_hive_model.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

part 'board_hive_model.g.dart';

@HiveType(typeId: 0)
class BoardHiveModel extends Equatable {
  @HiveField(0)
  final String? boardId;
  @HiveField(1)
  final String boardName;
  @HiveField(2)
  final String? description;
  @HiveField(3)
  final List<dynamic> items;
  @HiveField(4)
  final String? userId;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final DateTime updatedAt;
  @HiveField(7)
  final bool isSynced;

  const BoardHiveModel({
    this.boardId,
    required this.boardName,
    this.description,
    this.items = const [],
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.isSynced,
    required bool isFavorite,
  });

  // initial constructor
  BoardHiveModel.initial()
      : boardId = '',
        boardName = '',
        description = '',
        items = const [],
        userId = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        isSynced = false;

  // from entity
  factory BoardHiveModel.fromEntity(Map<String, dynamic> entity) {
    return BoardHiveModel(
      boardId: entity['boardId'],
      boardName: entity['boardName'],
      description: entity['description'],
      items: entity['items'],
      userId: entity['userId'],
      createdAt: entity['createdAt'],
      updatedAt: entity['updatedAt'],
      isSynced: entity['isSynced'],
      isFavorite: false,
    );
  }

  // to entity
  BoardEntity toEntity() {
    return BoardEntity(
      boardId: boardId,
      boardName: boardName,
      description: description,
      items: BoardHiveModel.toEntityList(items.cast<String>()),
      userId: userId ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  @override
  List<Object?> get props =>
      [boardId, boardName, description, items, userId, createdAt, updatedAt];

  get isFavorite => null;

  static toEntityList(List<String>? boards) {}
}
