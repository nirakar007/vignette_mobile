import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'board_item_hive_model.g.dart';

@HiveType(typeId: 1)
class BoardItemHiveModel extends Equatable {
  @HiveField(1)
  final String content;
  @HiveField(2)
  final double positionX;
  @HiveField(3)
  final double positionY;

  const BoardItemHiveModel({
    required this.content,
    required this.positionX,
    required this.positionY, required isCompleted, required itemId, required itemName,
  });

  @override
  List<Object?> get props => [content, positionX, positionY];

  static toEntityList(List<BoardItemHiveModel> items) {}
}
