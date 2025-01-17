import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:vignette__mobile/app/constants/hive_table_constant.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';

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
  final List<String>? boards;
  @HiveField(5)
  final String? profilePicture;

  const AuthHiveModel(
      {this.userId,
      required this.email,
      required this.username,
      required this.password,
      this.boards,
      this.profilePicture});

  // initial constructor
  const AuthHiveModel.initial()
      : userId = '',
        email = '',
        username = '',
        password = '',
        boards = const [],
        profilePicture = null;

  // from entity
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      email: entity.email,
      username: entity.username,
      password: entity.password,
    );
  }

  // to entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      email: email,
      username: username,
      password: password,
      // boards: BoardHiveModel.toEntityList(boards),
      // profilePicture: profilePicture,
    );
  }

  @override
  List<Object?> get props =>
      [userId, email, username, password, boards, profilePicture];
}
