import 'package:equatable/equatable.dart';

class BoardEntity extends Equatable {
  final String? boardId;
  final String boardName;
  final String? description;
  final List<dynamic> items;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFavorite;
  final bool isSynced;

  const BoardEntity({
    this.boardId,
    required this.boardName,
    this.description,
    this.items = const [],
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.isFavorite = false,
    this.isSynced = false,
  });

  BoardEntity copyWith({
    String? boardId,
    String? boardName,
    String? description,
    List<dynamic>? items,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
    bool? isSynced,
  }) {
    return BoardEntity(
      boardId: boardId ?? this.boardId,
      boardName: boardName ?? this.boardName,
      description: description ?? this.description,
      items: items ?? this.items,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isFavorite: isFavorite ?? this.isFavorite,
      isSynced: isSynced ?? this.isSynced,
    );
  }

  @override
  List<Object?> get props => [
        boardId,
        boardName,
        description,
        items,
        userId,
        createdAt,
        updatedAt,
        isFavorite,
        isSynced,
      ];

  static Future<List<BoardEntity>> fromJson(json) async {
    return [];
  }
}

class BoardItem extends Equatable {
  final String type;
  final String content;
  final Position position;
  final Size size;
  final String image;
  final DateTime? createdAt;

  const BoardItem({
    required this.type,
    required this.content,
    this.position = const Position(),
    this.size = const Size(),
    required this.image,
    this.createdAt,
  });

  @override
  List<Object?> get props => [type, content, position, size, image, createdAt];
}

class Position extends Equatable {
  final double x;
  final double y;

  const Position({this.x = 0.0, this.y = 0.0});

  @override
  List<Object?> get props => [x, y];
}

class Size extends Equatable {
  final double width;
  final double height;

  const Size({this.width = 100.0, this.height = 100.0});

  @override
  List<Object?> get props => [width, height];
}
