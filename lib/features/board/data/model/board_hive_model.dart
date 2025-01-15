import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vignette__mobile/features/board/data/model/board_item_hive_model.dart';

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
  final List<BoardItemHiveModel> items;
  @HiveField(4)
  final String? userId;
  @HiveField(5)
  final DateTime createdAt;
  @HiveField(6)
  final DateTime updatedAt;

  const BoardHiveModel({
    this.boardId,
    required this.boardName,
    this.description,
    this.items = const [],
    this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [boardId, boardName, description, items, userId, createdAt, updatedAt];
}
