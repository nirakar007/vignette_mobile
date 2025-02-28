import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

part 'board_api_model.g.dart';

@JsonSerializable()
class BoardApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? boardId;
  final String boardName;
  final String description;
  final List<dynamic> items;
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isSynced;
  final bool isFavorite;

  const BoardApiModel(
      {this.boardId,
      required this.boardName,
      required this.description,
      required this.items,
      required this.createdAt,
      required this.updatedAt,
      required this.isSynced,
      required this.isFavorite,
      this.userId});

  BoardApiModel.empty()
      : boardId = '',
        boardName = '',
        description = '',
        items = const [],
        userId = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        isSynced = false,
        isFavorite = false;

  //From Json,
  //Server => dart
  factory BoardApiModel.fromJson(Map<String, dynamic> json) {
    return BoardApiModel(
      boardId: json['boardId'],
      boardName: json['boardName'],
      description: json['description'],
      items: json['items'],
      userId: json['userId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      isSynced: json['isSynced'],
      isFavorite: json['isFavorite'],
    );
  }

  //To Json`
  //dart => Server
  BoardEntity toJson() {
    return BoardEntity(
      boardName: boardName,
      userId: userId ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
      isFavorite: isFavorite,
      isSynced: isSynced,
    );
  }

  //From Entity
  static BoardApiModel fromEntity(BoardEntity entity) => BoardApiModel(
        boardName: entity.boardName,
        description: entity.description ?? '',
        items: entity.items,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
        isSynced: entity.isSynced,
        isFavorite: entity.isFavorite,
      );

  // To Entity
  BoardEntity toEntity() => BoardEntity(
        boardId: boardId,
        boardName: boardName,
        userId: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isFavorite: isFavorite,
      );

  //to Entity List

  static List<BoardEntity> toEntityList(List<BoardApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

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
        isSynced
      ];
}
