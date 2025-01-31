// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_boards_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllBoardsDTO _$GetAllBoardsDTOFromJson(Map<String, dynamic> json) =>
    GetAllBoardsDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => BoardApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllBoardsDTOToJson(GetAllBoardsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
