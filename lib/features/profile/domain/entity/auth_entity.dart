import 'package:equatable/equatable.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

class AuthEntity extends Equatable {
  final String? profilePicture;
  final List<BoardEntity>? boards;
  final String username;
  final String email;
  final String password;
  final String? userId;
  final String? role;
  final String? plan;
  final bool? isBanned;
  final DateTime? lastLogin;
  final int? loginCount;
  final DateTime? planExpiresAt;
  final DateTime? createdAt;

  const AuthEntity({
    this.userId,
    required this.email,
    required this.username,
    required this.password,
    required this.boards,
    required this.profilePicture,
    required this.role,
    required this.plan,
    required this.isBanned,
    required this.lastLogin,
    required this.loginCount,
    required this.planExpiresAt,
    required this.createdAt,
  });

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
