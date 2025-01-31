import 'package:equatable/equatable.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String email;
  final String username;
  final String password;
  final String? profilePicture;
  final List<BoardEntity>? boards;

  const AuthEntity({
    this.userId,
    required this.email,
    required this.username,
    required this.password,
    this.boards,
    this.profilePicture,
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
