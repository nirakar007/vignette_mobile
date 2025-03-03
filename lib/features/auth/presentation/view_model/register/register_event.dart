part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class UploadImage extends RegisterEvent {
  final File file;

  const UploadImage({
    required this.file,
  });
}

class NavigateLoginScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String email;
  final String username;
  final String password;
  final String? profilePicture;

  const RegisterUser({
    required this.context,
    required this.email,
    required this.username,
    required this.password,
    this.profilePicture,
  });
}
