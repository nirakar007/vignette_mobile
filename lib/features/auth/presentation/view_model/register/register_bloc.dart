import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vignette__mobile/app/widget/showMySnackbar.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUseCase;
  final UploadImageUsecase _uploadImageUseCase;
  final LoginBloc _loginBloc;

  RegisterBloc({
    required RegisterUsecase registerUseCase,
    BoardBloc? boardBloc,
    required LoginBloc loginBloc,
    required UploadImageUsecase uploadImageUsecase,
  })  : _registerUseCase = registerUseCase,
        _uploadImageUseCase = uploadImageUsecase,
        _loginBloc = loginBloc,
        super(const RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);
    on<UploadImage>(_onLoadImage);
    on<NavigateLoginScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _loginBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    // add();
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    print("bloc ma imge ${state.imageName}");
    final result = await _registerUseCase.call(RegisterUserParams(
      email: event.email,
      username: event.username,
      password: event.password,
      profilePicture: state.imageName,
    ));

    result.fold(
      (l) => {
        emit(state.copyWith(isLoading: false, isSuccess: false)),
        showSnackbar(
            context: event.context,
            message: "Registration Successful!",
            color: Colors.green)
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showSnackbar(
            context: event.context,
            message: "Registration Successful",
            color: Colors.green);
      },
    );
  }

  void _onLoadImage(
    UploadImage event,
    Emitter<RegisterState> emit,
  ) async {
    print('HELLOUUU BLOC:: ');
    emit(state.copyWith(isLoading: true));
    print('HELLOUUU BLOC:: ');
    final result = await _uploadImageUseCase.call(
      UploadImageParams(
        file: event.file,
      ),
    );
    print('HELLOUUU BLOC:: $result');

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }
}
