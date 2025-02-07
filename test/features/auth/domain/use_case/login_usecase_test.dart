import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:vignette__mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/login_usecase.dart';

import 'login_usecase_test.mocks.dart';

// Generate mocks
@GenerateMocks([IAuthRepository, TokenSharedPrefs])
void main() {
  late LoginUseCase useCase;
  late IAuthRepository mockRepository;
  late TokenSharedPrefs mockTokenSharedPrefs;

  setUp(() {
    mockRepository = MockIAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    useCase = LoginUseCase(mockTokenSharedPrefs, repository: mockRepository);
  });

  const testUsername = 'testuser';
  const testPassword = 'password123';
  const testToken = 'test_token';
  const testParams =
      LoginParams(username: testUsername, password: testPassword);

  group('LoginUseCase', () {
    test('should return token when login is successful', () async {
      // Arrange
      when(mockRepository.loginUser(testUsername, testPassword))
          .thenAnswer((_) async => const Right(testToken));

      // Act
      final result = await useCase(testParams);

      // Assert
      expect(result, const Right(testToken));
      verify(mockRepository.loginUser(testUsername, testPassword)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}
