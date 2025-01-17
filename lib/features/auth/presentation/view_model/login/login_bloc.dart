import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/login_usecase.dart';
import 'package:vignette__mobile/features/home/presentation/view/home_view.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<LoginUserEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          LoginParams(
            username: event.username,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            ScaffoldMessenger.of(event.context).showSnackBar(
              const SnackBar(
                content: Text("Invalid Credentials"),
                backgroundColor: Colors.red,
              ),
            );
          },
          (token) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            Navigator.pushReplacement(
              event.context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        );
      },
    );

    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(builder: (context) => event.destination),
        );
      },
    );
  }
}
