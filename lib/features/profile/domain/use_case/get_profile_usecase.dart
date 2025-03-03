// features/profile/domain/use_case/get_profile_usecase.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vignette__mobile/core/error/exceptions.dart';
import 'package:vignette__mobile/features/profile/data/model/user_profile_model.dart';

abstract class GetProfileDataSource {
  Future<UserProfile> getProfile(String userId);
}

class GetProfileRemoteDataSource implements GetProfileDataSource {
  @override
  Future<UserProfile> getProfile(String userId) async {
    final response = await http.get(
      Uri.parse('http://localhost:5000/api/v1/users/getMe/$userId'),
    );

    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw ServerException(message: 'Failed to load profile');
    }
  }
}

class GetProfileUseCase {
  final GetProfileDataSource dataSource;

  GetProfileUseCase({required this.dataSource});

  Future<UserProfile> call(String userId) async {
    try {
      return await dataSource.getProfile(userId);
    } catch (e) {
      throw ProfileException(message: e.toString());
    }
  }
}