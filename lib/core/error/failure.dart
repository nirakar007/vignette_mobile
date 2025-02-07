import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class AuthFailure extends Failure {
  @override
  final String message;

  const AuthFailure({required this.message}) : super(message: 'Auth Failed');

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AuthFailure: $message';
}

class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

class ApiFailure extends Failure {
  final int? statusCode;
  const ApiFailure({
    this.statusCode,
    required super.message,
  });
}

class SharedPrefsFailure extends Failure {
  const SharedPrefsFailure({
    required super.message,
  });
}
