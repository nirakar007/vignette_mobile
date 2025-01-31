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
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String updateStudent = "auth/updateUser/";
  static const String deleteStudent = "auth/deleteUser/";
  static const String imageUrl = "http://10.0.2.2:3001/uploads/";
  static const String uploadImage = "auth/uploadImage";
}
