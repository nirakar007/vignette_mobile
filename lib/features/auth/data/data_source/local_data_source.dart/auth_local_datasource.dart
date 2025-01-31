import 'dart:io';

import 'package:vignette__mobile/core/network/hive_service.dart';
import 'package:vignette__mobile/features/auth/data/data_source/auth_data_source.dart';
import 'package:vignette__mobile/features/auth/data/model/auth_hive_model.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDatasource implements IAuthDataSource {
  final HiveService _hiveService;

  AuthLocalDatasource(this._hiveService);

  @override
  Future<AuthEntity> getCurrentUser() {
    return Future.value(const AuthEntity(
        userId: '1',
        email: '',
        username: '',
        password: '',
        boards: [],
        profilePicture: null));
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      await _hiveService.login(username, password);
      return Future.value("Success");
    } catch (e) {
      throw Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity user) async {
    try {
      final authHiveModel = AuthHiveModel.fromEntity(user);
      await _hiveService.register(authHiveModel);
      return Future.value();
    } catch (e) {
      throw Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File filePath) {
    throw UnimplementedError();
  }
}
