part of 'register_bloc.dart';

class RegisterState {
  final bool isLoading;
  final bool isSuccess;

  RegisterState({
    this.isLoading = false,
    this.isSuccess = false,
  });

  RegisterState.initial()
      : isLoading = false,
        isSuccess = false;

  RegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
