// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      id: json['_id'] as String?,
      profilePicture: json['profilePicture'] as String?,
      boards: (json['boards'] as List<dynamic>)
          .map((e) => BoardApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      email: json['email'] as String,
      username: json['username'] as String,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'profilePicture': instance.profilePicture,
      'boards': instance.boards,
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
