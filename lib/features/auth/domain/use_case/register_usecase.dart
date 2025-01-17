import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vignette__mobile/app/usecase/usecase.dart';
import 'package:vignette__mobile/core/error/failure.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';

class RegisterUserParams extends Equatable {
  final String email;
  final String username;
  final String password;

  const RegisterUserParams({
    required this.email,
    required this.username,
    required this.password,
  });

  // initial constructor
  const RegisterUserParams.initial({
    this.email = '',
    this.username = '',
    this.password = '',
  });

  @override
  List<Object?> get props => [email, username, password];
}

class RegisterUsecase implements UseCaseWithParams<void, RegisterUserParams> {
  final IAuthRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) async {
    final authEntity = AuthEntity(
      email: params.email,
      username: params.username,
      password: params.password,
    );
    return repository.registerUser(authEntity);
  }
}
