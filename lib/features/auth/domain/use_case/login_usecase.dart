import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vignette__mobile/app/usecase/usecase.dart';
import 'package:vignette__mobile/core/error/failure.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';

class LoginParams extends Equatable {
  final String username;
  final String password;

  const LoginParams({
    required this.username,
    required this.password,
  });

  // Initial Constructor
  const LoginParams.initial()
      : username = '',
        password = '';

  @override
  List<Object> get props => [username, password];
}

class LoginUseCase implements UseCaseWithParams<String, LoginParams> {
  final IAuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return repository.loginUser(params.username, params.password);
  }
}
