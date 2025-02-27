import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:vignette__mobile/features/board/data/model/board_api_model.dart';

part 'auth_api_model.g.dart';

// API - FromJson, ToJson and conversion between API model and entity

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String? profilePicture;
  final List<BoardApiModel> boards;
  final String username;
  final String email;
  final String? password;
  final String? role;
  final DateTime createdAt;

  const AuthApiModel({
    this.id,
    required this.profilePicture,
    required this.boards,
    required this.username,
    required this.email,
    required this.password,
    this.role,
    required this.createdAt,
  });

  // From JSON
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // Convert to Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: id,
      profilePicture: profilePicture,
      boards: boards.map((e) => e.toEntity()).toList(),
      username: username,
      email: email,
      password: password ?? '',
      role: role ?? '',
      createdAt: createdAt,
      plan: 'free',
      isBanned: false,
      lastLogin: null,
      loginCount: null,
      planExpiresAt: null,
    );
  }

  // Convert from Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      id: entity.userId,
      profilePicture: entity.profilePicture,
      email: entity.email,
      boards:
          entity.boards?.map((e) => BoardApiModel.fromEntity(e)).toList() ?? [],
      username: entity.username,
      password: entity.password,
      createdAt: DateTime.now(), // Assuming current timestamp if missing
    );
  }

  @override
  List<Object?> get props =>
      [id, profilePicture, boards, email, username, password, role, createdAt];
}
