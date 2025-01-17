import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String email, String password);
  Future<void> registerUser(AuthEntity user);
  Future<AuthEntity> getCurrentUser();
  Future<String> uploadProfilePicture(String filePath);
}
