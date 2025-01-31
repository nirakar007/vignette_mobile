// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardApiModel _$BoardApiModelFromJson(Map<String, dynamic> json) =>
    BoardApiModel(
      boardId: json['_id'] as String?,
      boardName: json['boardName'] as String,
    );

Map<String, dynamic> _$BoardApiModelToJson(BoardApiModel instance) =>
    <String, dynamic>{
      '_id': instance.boardId,
      'boardName': instance.boardName,
    };
