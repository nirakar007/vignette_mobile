// features/profile/domain/use_case/update_profile_usecase.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vignette__mobile/core/error/exceptions.dart';
import 'package:vignette__mobile/features/profile/data/model/user_profile_model.dart';

class UpdateProfileParams {
  final String userId;
  final String username;
  final String email;
  final String? bio;
  final String? profilePicture;

  UpdateProfileParams({
    required this.userId,
    required this.username,
    required this.email,
    this.bio,
    this.profilePicture,
  });
}

abstract class UpdateProfileDataSource {
  Future<UserProfile> updateProfile(UpdateProfileParams params);
}

class UpdateProfileRemoteDataSource implements UpdateProfileDataSource {
  @override
  Future<UserProfile> updateProfile(UpdateProfileParams params) async {
    final response = await http.put(
      Uri.parse('http://localhost:5000/api/v1/users/updateMe/${params.userId}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': params.username,
        'email': params.email,
        'bio': params.bio,
        'profilePicture': params.profilePicture,
      }),
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Failed to update profile');
    }
  }
}

class UpdateProfileUseCase {
  final UpdateProfileDataSource dataSource;

  UpdateProfileUseCase({required this.dataSource});

  Future<UserProfile> call(UpdateProfileParams params) async {
    try {
      return await dataSource.updateProfile(params);
    } catch (e) {
      throw ProfileException(message: e.toString());
    }
  }
}
