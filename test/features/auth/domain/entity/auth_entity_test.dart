import 'package:flutter_test/flutter_test.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';
import 'package:vignette__mobile/features/board/domain/entity/board_entity.dart';

class MockBoardEntity extends BoardEntity {
  const MockBoardEntity()
      : super(boardName: 'Test Board'); // Add proper super parameters if needed
}

void main() {
  group('AuthEntity', () {
    const testEmail = 'test@example.com';
    const testUsername = 'testuser';
    const testPassword = 'password123';
    const testUserId = 'user123';
    const testProfilePicture = 'path/to/image.jpg';
    final testBoards = [const MockBoardEntity()];

    // Test 1: Required fields initialization
    test('1. should correctly initialize required fields', () {
      const authEntity = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: testPassword,
      );

      expect(authEntity.email, testEmail);
      expect(authEntity.username, testUsername);
      expect(authEntity.password, testPassword);
      expect(authEntity.userId, isNull);
      expect(authEntity.profilePicture, isNull);
      expect(authEntity.boards, isNull);
    });

    // Test 2: Optional fields initialization
    test('2. should correctly initialize optional fields', () {
      var authEntity = AuthEntity(
        userId: testUserId,
        email: testEmail,
        username: testUsername,
        password: testPassword,
        profilePicture: testProfilePicture,
        boards: testBoards,
      );

      expect(authEntity.userId, testUserId);
      expect(authEntity.profilePicture, testProfilePicture);
      expect(authEntity.boards, testBoards);
    });

    // Test 3: Equality check with same properties
    test('3. should be equal when properties are identical', () {
      const authEntity1 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: testPassword,
      );
      const authEntity2 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: testPassword,
      );

      expect(authEntity1, equals(authEntity2));
    });

    // Test 4: Inequality with different userId
    test('4. should not be equal with different userId', () {
      const authEntity1 = AuthEntity(
        userId: 'user1',
        email: testEmail,
        username: testUsername,
        password: testPassword,
      );
      const authEntity2 = AuthEntity(
        userId: 'user2',
        email: testEmail,
        username: testUsername,
        password: testPassword,
      );

      expect(authEntity1, isNot(equals(authEntity2)));
    });

    // Test 5: Inequality with different email
    test('5. should not be equal with different email', () {
      const authEntity1 = AuthEntity(
        email: 'email1@test.com',
        username: testUsername,
        password: testPassword,
      );
      const authEntity2 = AuthEntity(
        email: 'email2@test.com',
        username: testUsername,
        password: testPassword,
      );

      expect(authEntity1, isNot(equals(authEntity2)));
    });

    // Test 6: Inequality with different username
    test('6. should not be equal with different username', () {
      const authEntity1 = AuthEntity(
        email: testEmail,
        username: 'user1',
        password: testPassword,
      );
      const authEntity2 = AuthEntity(
        email: testEmail,
        username: 'user2',
        password: testPassword,
      );

      expect(authEntity1, isNot(equals(authEntity2)));
    });

    // Test 7: Inequality with different password
    test('7. should not be equal with different password', () {
      const authEntity1 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: 'password1',
      );
      const authEntity2 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: 'password2',
      );

      expect(authEntity1, isNot(equals(authEntity2)));
    });

    // Test 8: Inequality with different profilePicture
    test('8. should not be equal with different profilePicture', () {
      const authEntity1 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: testPassword,
        profilePicture: 'image1.jpg',
      );
      const authEntity2 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: testPassword,
        profilePicture: 'image2.jpg',
      );

      expect(authEntity1, isNot(equals(authEntity2)));
    });

    // Test 9: should not be equal with different boards
    test('9. should not be equal with different boards', () {
      const authEntity1 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: testPassword,
        boards: [
          BoardEntity(boardId: '1', boardName: 'Board A'),
        ],
      );

      const authEntity2 = AuthEntity(
        email: testEmail,
        username: testUsername,
        password: testPassword,
        boards: [
          BoardEntity(
              boardId: '2', // Different boardId
              boardName: 'Board B' // Different boardName
              ),
        ],
      );

      expect(authEntity1, isNot(equals(authEntity2)));
    });

    // Test 10: Props list verification
    test('10. props should contain all fields in correct order', () {
      var authEntity = AuthEntity(
        userId: testUserId,
        email: testEmail,
        username: testUsername,
        password: testPassword,
        profilePicture: testProfilePicture,
        boards: testBoards,
      );

      expect(
        authEntity.props,
        [
          testUserId,
          testEmail,
          testUsername,
          testPassword,
          testBoards,
          testProfilePicture,
        ],
      );
    });
  });
}
