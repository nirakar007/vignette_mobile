import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

part 'board_api_model.g.dart';

@JsonSerializable()
class BoardApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? boardId;
  final String boardName;

  const BoardApiModel({
    this.boardId,
    required this.boardName,
  });

  const BoardApiModel.empty()
      : boardId = '',
        boardName = '';

  //From Json,
  //Server => dart
  factory BoardApiModel.fromJson(Map<String, dynamic> json) {
    return BoardApiModel(
      boardId: json['_id'],
      boardName: json['courseName'],
    );
  }

  //To Json
  //dart => Server
  Map<String, dynamic> toJson() {
    return {
      'boardName': boardName,
    };
  }

  //From Entity
  static BoardApiModel fromEntity(BoardEntity entity) => BoardApiModel(
        boardName: entity.boardName,
      );

  // To Entity
  BoardEntity toEntity() => BoardEntity(
        boardId: boardId,
        boardName: boardName,
      );

  //to Entity List

  static List<BoardEntity> toEntityList(List<BoardApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [boardId, boardName];
}
