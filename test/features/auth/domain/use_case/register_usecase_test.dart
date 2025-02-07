import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vignette__mobile/core/error/failure.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';

import 'fake_auth_repo.dart';

// Mock class for AuthRepository
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late FakeAuthRepository repository;
  late RegisterUsecase usecase;

  setUp(() {
    repository = FakeAuthRepository();
    usecase = RegisterUsecase(repository);
  });
  group("RegisterUsecase", () {
    test('should register user successfully', () async {
      const params = RegisterUserParams(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
        profilePicture: 'profile.jpg',
      );

      final result = await usecase(params);

      expect(result, const Right(null));
    });

    test('should return ApiFailure when user registration fails', () async {
      repository.shouldFail = true;

      const params = RegisterUserParams(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
        profilePicture: 'profile.jpg',
      );

      final result = await usecase(params);

      expect(result, const Left(ApiFailure(message: "Registration failed")));
    });
  });
}
