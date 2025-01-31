import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vignette__mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:vignette__mobile/core/network/api_service.dart';
import 'package:vignette__mobile/core/network/hive_service.dart';
import 'package:vignette__mobile/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:vignette__mobile/features/auth/data/data_source/local_data_source.dart/auth_local_datasource.dart';
import 'package:vignette__mobile/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:vignette__mobile/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/login_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:vignette__mobile/features/board/data/data_source/local_data_source/board_local_data_source.dart';
import 'package:vignette__mobile/features/board/data/data_source/remote_data_source/board_remote_data_source.dart';
import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';
import 'package:vignette__mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:vignette__mobile/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initBoardDependencies();
  await _initHomeDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();

  await _initSplashScreenDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initApiService() {
  // Remote Data Source
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
// =========================== Data Source ===========================

  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );
  
  getIt.registerLazySingleton<BoardRemoteDataSource>(
    () => BoardRemoteDataSource(getIt<Dio>()),
  );



  // =========================== Repository ===========================

  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<BoardBloc>(
      () => BoardBloc(getIt<BoardRemoteDataSource>()));

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      boardBloc: getIt<BoardBloc>(),
      registerUseCase: getIt(),
      uploadImageUsecase: getIt(),
    ),
  );
}

_initBoardDependencies() {
  // =========================== Data Source ===========================

  getIt.registerFactory<BoardLocalDataSource>(
      () => BoardLocalDataSource(getIt<HiveService>()));

  // =========================== Repository ===========================

  // getIt.registerLazySingleton<BoardLocalRepository>(() => BoardLocalRepository(
  //     boardLocalDatasource: getIt<BoardLocalDataSource>()));

  // getIt.registerLazySingleton<CourseRemoteRepository>(
  //   () => CourseRemoteRepository(
  //     getIt<CourseRemoteDataSource>(),
  //   ),
  // );

  // Usecases
  // getIt.registerLazySingleton<CreateCourseUsecase>(
  //   () => CreateCourseUsecase(
  //     courseRepository: getIt<CourseRemoteRepository>(),
  //   ),
  // );

  // getIt.registerLazySingleton<GetAllCourseUsecase>(
  //   () => GetAllCourseUsecase(
  //     courseRepository: getIt<CourseRemoteRepository>(),
  //   ),
  // );

  // getIt.registerLazySingleton<DeleteCourseUsecase>(
  //   () => DeleteCourseUsecase(
  //     courseRepository: getIt<CourseLocalRepository>(),
  //   ),
  // );

  // Bloc

  // getIt.registerFactory<CourseBloc>(
  //   () => CourseBloc(
  //     getAllCourseUsecase: getIt<GetAllCourseUsecase>(),
  //     createCourseUsecase: getIt<CreateCourseUsecase>(),
  //     deleteCourseUsecase: getIt<DeleteCourseUsecase>(),
  //   ),
  // );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<TokenSharedPrefs>(),
      repository: getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
