import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:vignette__mobile/features/board/data/model/board_api_model.dart';

part 'auth_api_model.g.dart';

// api - 2 from json to json and from and to entity
// hive - 1 from and to entity

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id; // because mongoDB auto generates the id
  final String? profilePicture;
  final List<BoardApiModel> boards;
  final String username;
  final String email;
  final String? password; // we do not need to get the password

  const AuthApiModel({
    this.id,
    required this.profilePicture,
    required this.boards,
    required this.email,
    required this.username,
    required this.password,
  });

  //From Json, To Json generator
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To entity
  AuthEntity toEntity() {
    return AuthEntity(
      profilePicture: profilePicture,
      boards: boards.map((e) => e.toEntity()).toList(),
      username: username,
      email: '',
      password: password ?? '',
    );
  }

  //From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
        id: entity.userId,
        profilePicture: entity.profilePicture,
        email: entity.email,
        boards:
            entity.boards?.map((e) => BoardApiModel.fromEntity(e)).toList() ??
                [],
        username: entity.username,
        password: entity.password);
  }

  @override
  List<Object?> get props =>
      [id, profilePicture, boards, email, username, password];
}
