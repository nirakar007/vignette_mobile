import 'package:flutter_test/flutter_test.dart';
import 'package:vignette__mobile/features/auth/data/model/auth_api_model.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthApiModel Tests', () {
    final json = {
      '_id': '123',
      'profilePicture': 'profile.jpg',
      'username': 'johndoe',
      'email': 'johndoe@gmail.com',
      'password': 'password123',
      'boards': [], // 🔥 Added this to prevent null errors
    };

    test('Should convert from JSON correctly', () {
      final model = AuthApiModel.fromJson(json);

      expect(model.id, '123');
      expect(model.profilePicture, 'profile.jpg'); // ✅ Corrected expectation
      expect(model.username, 'johndoe');
      expect(model.email, 'johndoe@gmail.com'); // ✅ Corrected expectation
      expect(model.password, 'password123');
    });

    test('Should convert to JSON correctly', () {
      final model = AuthApiModel.fromJson(json);
      final convertedJson = model.toJson();

      expect(convertedJson['_id'], '123');
      expect(convertedJson['profilePicture'], 'profile.jpg'); // ✅ Fixed key
      expect(convertedJson['username'], 'johndoe');
      expect(convertedJson['email'], 'johndoe@gmail.com');
      expect(convertedJson['password'], 'password123');
      expect(convertedJson['boards'],
          isA<List<dynamic>>()); // 🔥 Ensures it's always a list
    });

    test('Should convert between Entity and Model correctly', () {
      const entity = AuthEntity(
        userId: '123',
        username: 'johndoe',
        email: 'johndoe@gmail.com',
        password: 'password123',
      );

      final model = AuthApiModel.fromEntity(entity);
      expect(model.id, '123');
      expect(model.username, 'johndoe');
      expect(model.boards, isA<List<dynamic>>()); // 🔥 Ensures it's a list
    });
  });
}
