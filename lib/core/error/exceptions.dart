// core/error/exceptions.dart
class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class ProfileException implements Exception {
  final String message;
  ProfileException({required this.message});
}
