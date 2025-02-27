import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vignette__mobile/app/constants/hive_table_constant.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:vignette__mobile/features/board/data/model/board_hive_model.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final List<BoardHiveModel>? boards;
  @HiveField(5)
  final String? profilePicture;

  const AuthHiveModel({
    this.userId,
    required this.email,
    required this.username,
    required this.password,
    this.boards,
    this.profilePicture,
  });

  const AuthHiveModel.initial()
      : userId = null,
        email = '',
        username = '',
        password = '',
        boards = null,
        profilePicture = null;

  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      userId: entity.userId,
      email: entity.email,
      username: entity.username,
      password: entity.password,
      boards: entity.boards
          ?.map((board) =>
              BoardHiveModel.fromEntity(board as Map<String, dynamic>))
          .toList(),
      profilePicture: entity.profilePicture,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      email: email,
      username: username,
      password: password,
      boards: boards?.map((board) => board.toEntity()).toList() ?? [],
      profilePicture: profilePicture,
      role: '', // default role value
      plan: '', // default plan value
      isBanned: false, // default banned status
      lastLogin: DateTime.now(), // default lastLogin timestamp
      loginCount: 0, // default login count
      planExpiresAt: DateTime.now(), // default planExpiresAt timestamp
      createdAt: DateTime.now(), // default createdAt timestamp
    );
  }

  @override
  List<Object?> get props => [
        userId,
        email,
        username,
        password,
        boards,
        profilePicture,
      ];
}
