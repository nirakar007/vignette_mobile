import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUseCase;

  RegisterBloc({
    required RegisterUsecase registerUsecase,
    required BoardBloc boardBloc,
  })  : _registerUseCase = registerUsecase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);

    add(const RegisterUser(email: '', username: '', password: ''));
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      email: event.email,
      password: event.password,
      username: event.username,
    ));

    result.fold((failure) {
      print('Registration failed: $failure');
      emit(state.copyWith(isLoading: false, isSuccess: false));
    }, (success) {
      print('Registration successful');
      emit(state.copyWith(isLoading: false, isSuccess: true));
    });
  }
}
