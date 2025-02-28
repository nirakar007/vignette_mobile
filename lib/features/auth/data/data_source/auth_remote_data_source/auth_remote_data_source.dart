import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:vignette__mobile/app/constants/api_endpoints.dart';
import 'package:vignette__mobile/core/error/failure.dart';
import 'package:vignette__mobile/features/auth/data/data_source/auth_data_source.dart';
import 'package:vignette__mobile/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDataSource implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> registerUser(AuthEntity user) async {
    try {
      var pic = user.profilePicture;
      Map<String, Object?> data;
      if (pic != null) {
       data={  "username": user.username,
          "email": user.email,
          "password": user.password,
          "profilePicture": user.profilePicture,
          "boards": user.boards,
        };
        
      } else {
       data= {
          "username": user.username,
          "email": user.email,
          "password": user.password,
          "boards": user.boards,
        }
      }
      Response response = await _dio.post(ApiEndpoints.register, data: data);
      if (response.statusCode == 201) {
        return const Right(null);
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      print("Uploading file: $fileName at path: ${file.path}");

      // FormData formData = FormData.fromMap({
      //   "profilePicture": await MultipartFile.fromFile(
      //     file.path,
      //     filename: fileName,
      //   ),
      // });

      FormData formData = FormData.fromMap(
          {'profilePicture': await MultipartFile.fromFile(file.path)});
      Response response = await _dio.put(
          'http://10.0.2.2:3001/users/updateProfilePicture', // Update the URL to match the correct API route
          data: formData,
          options: Options(
            headers: {"Content-Type": "multipart/form-data"},
          ));
      // Response response = await _dio.post(
      //   ApiEndpoints.uploadImage,
      //   data: formData,
      //   options: Options(
      //     headers: {"Content-Type": "multipart/form-data"},
      //   ),
      // );

      print("Response Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
