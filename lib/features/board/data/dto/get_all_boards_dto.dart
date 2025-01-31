import 'package:json_annotation/json_annotation.dart';
import 'package:vignette__mobile/features/board/data/model/board_api_model.dart';

part 'get_all_boards_dto.g.dart';

@JsonSerializable()
class GetAllBoardsDTO {
  final bool success;
  final int count;
  final List<BoardApiModel> data;

  GetAllBoardsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllBoardsDTOToJson(this);

  factory GetAllBoardsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllBoardsDTOFromJson(json);
}
