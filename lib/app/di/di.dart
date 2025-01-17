import 'package:get_it/get_it.dart';
import 'package:vignette__mobile/core/network/hive_service.dart';
import 'package:vignette__mobile/features/auth/data/data_source/local_data_source.dart/auth_local_datasource.dart';
import 'package:vignette__mobile/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/login_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';
import 'package:vignette__mobile/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initHiveService();
  _initSplashDependencies();
  _initBoardDependencies();
  _initRegisterDependencies();
  _initLoginDependencies();
}

void _initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

void _initLoginDependencies() {
  getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: getIt()));
  getIt.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: getIt()));
}

void _initSplashDependencies() {
  getIt.registerFactory<SplashCubit>(() => SplashCubit(getIt<LoginBloc>()));
}

void _initBoardDependencies() {
  getIt.registerFactory<BoardBloc>(() => BoardBloc(getIt()));
}

void _initRegisterDependencies() {
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthLocalRepository(authLocalDataSource: getIt()),
  );
  getIt.registerLazySingleton<AuthLocalRepository>(
    () => AuthLocalRepository(authLocalDataSource: getIt()),
  );

  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(getIt<AuthLocalRepository>()),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      boardBloc: getIt<BoardBloc>(),
      registerUsecase: getIt<RegisterUsecase>(),
    ),
  );
}
