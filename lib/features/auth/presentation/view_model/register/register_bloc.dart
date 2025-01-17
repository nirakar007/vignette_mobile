import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase _registerUsecase;

  RegisterBloc({
    required RegisterUsecase registerUsecase,
  })  : _registerUsecase = registerUsecase,
        super(RegisterState.initial()) {
    on<RegisterUser>(_onRegisterEvent);

    add(const RegisterUser(
        email: '', username: '', password: '', confirmPassword: ''));
  }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUsecase.call(RegisterUserParams(
      email: event.email,
      password: event.password,
      username: event.username,
      confirmPassword: event.confirmPassword  ,
    ));

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (success) => emit(state.copyWith(isLoading: false, isSuccess: true)),
    );
  }
}
