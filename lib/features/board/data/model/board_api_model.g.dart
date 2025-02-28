// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardApiModel _$BoardApiModelFromJson(Map<String, dynamic> json) =>
    BoardApiModel(
      boardId: json['_id'] as String?,
      boardName: json['boardName'] as String,
      description: json['description'] as String,
      items: json['items'] as List<dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isSynced: json['isSynced'] as bool,
      isFavorite: json['isFavorite'] as bool,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$BoardApiModelToJson(BoardApiModel instance) =>
    <String, dynamic>{
      '_id': instance.boardId,
      'boardName': instance.boardName,
      'description': instance.description,
      'items': instance.items,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isSynced': instance.isSynced,
      'isFavorite': instance.isFavorite,
    };
