import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vignette__mobile/core/error/failure.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';

class FakeAuthRepository implements IAuthRepository {
  bool shouldFail = false;

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity authEntity) async {
    if (shouldFail) {
      return const Left(ApiFailure(message: "Registration failed"));
    }
    return const Right(null);
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String username, String password) async {
    return const Right("fake_token");
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return const Right("image_url");
  }
  
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
