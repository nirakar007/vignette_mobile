class ApiEndpoints {
  // dio and dio logger
  // we need interceptor why? there are many status codes in a server. to capture each of those errors,
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = 'http://10.0.2.2:5000/api/v1/';

  // Board Routes ---------
  static const String createBoard = "boards/createBoard";
  static const String deleteBoard = "boards/deleteBoard";
  static const String getBoard = "boards/getBoard/";
  static const String getAllBoards = "boards/getBoards";
  static const String toggleFavorite = "boards/toggleFavorite";
  static const String updateBoard = "boards/updateBoard/";
  static const String searchBoards = "boards/searchBoards/";
  static const String exportBoard = "boards/exportBoard";

  // Auth Routes ---------
  static const String login = "users/login";
  static const String register = "users/register";
  static const String updateStudent = "users/updateUser/";
  static const String deleteStudent = "users/deleteUser/";
  static const String uploadImage = "users/uploadImage";
  static const String imageUrl = "http://10.0.2.2:3000/uploads/";
}
