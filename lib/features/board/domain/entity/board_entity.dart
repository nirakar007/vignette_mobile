import 'package:equatable/equatable.dart';

class BoardEntity extends Equatable {
  final String? boardId;
  final String? boardName;
  final String? description;
  final List<BoardItem> items;
  final String? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BoardEntity({
    this.boardId,
    this.boardName,
    this.description,
    this.items = const [],
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props =>
      [boardId, boardName, description, items, userId, createdAt, updatedAt];
}

// subclass to represent individual items in the board
class BoardItem extends Equatable {
  final String? type;
  final String? content;
  final String? position;

  const BoardItem({this.type, this.content, this.position});

  @override
  List<Object?> get props => [type, content, position];
}

// subclass to represent position coordinates
class Position extends Equatable {
  final double x;
  final double y;

  const Position({this.x = 0.0, this.y = 0.0});

  @override
  List<Object?> get props => [x, y];
}
