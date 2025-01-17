import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vignette__mobile/core/error/failure.dart';
import 'package:vignette__mobile/features/auth/data/data_source/local_data_source.dart/auth_local_datasource.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDatasource authLocalDataSource;

  AuthLocalRepository({required this.authLocalDataSource});

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
      String username, String password) async {
    try {
      final token = await authLocalDataSource.loginUser(username, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      return Right(authLocalDataSource.registerUser(user));
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }
}
