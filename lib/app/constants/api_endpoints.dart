class ApiEndpoints {
  // dio and dio logger
  // we need interceptor why? there are many status codes in a server. to capture each of those errors,
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = 'http://10.0.2.2:3001/api/v1/';

  // Board Routes ---------
  static const String createBoard = "board/createBoard";
  static const String getAllBoards = "board/getAllBoards";

  // Auth Routes ---------
  static const String login = "/api/v1/users/login";
  static const String register = "/api/v1/users/register";
  static const String updateStudent = "/api/v1/users/updateUser/";
  static const String deleteStudent = "/api/v1/users/deleteUser/";
  static const String uploadImage = "/api/v1/users/uploadImage";
  static const String imageUrl = "http://10.0.2.2:3001/uploads/";
}
