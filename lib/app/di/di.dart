import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vignette__mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:vignette__mobile/core/common/internet_checker/network_info.dart';
import 'package:vignette__mobile/core/network/api_service.dart';
import 'package:vignette__mobile/core/network/hive_service.dart';
// import 'package:vignette__mobile/core/network/network_info.dart';
import 'package:vignette__mobile/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
import 'package:vignette__mobile/features/auth/data/data_source/local_data_source.dart/auth_local_datasource.dart'
    show AuthLocalDatasource;
// Corrected import for the local data source:
import 'package:vignette__mobile/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:vignette__mobile/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/login_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';
import 'package:vignette__mobile/features/board/data/data_source/remote_data_source/board_remote_data_source.dart';
import 'package:vignette__mobile/features/board/data/repository/remote_repository/board_remote_repository.dart';
import 'package:vignette__mobile/features/board/domain/use_case/create_board_usecase.dart';
import 'package:vignette__mobile/features/board/domain/use_case/delete_board_usecase.dart';
// Assuming these use case classes exist:
import 'package:vignette__mobile/features/board/domain/use_case/get_boards_usecase.dart';
import 'package:vignette__mobile/features/board/domain/use_case/sync_boards_usecase.dart';
import 'package:vignette__mobile/features/board/domain/use_case/toggle_favourite_usecase.dart';
import 'package:vignette__mobile/features/board/domain/use_case/update_board_usecase.dart';
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
  getIt.registerLazySingleton<Dio>(() => ApiService(Dio()).dio);
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initBoardDependencies() {
  getIt.registerLazySingleton<BoardRemoteDataSource>(
    () => BoardRemoteDataSource(
      getIt<Dio>(),
    ),
  );
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  // Register NetworkInfo implementation
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt<Connectivity>()),
  );
  getIt.registerLazySingleton<BoardRemoteRepositoryImpl>(() =>
      BoardRemoteRepositoryImpl(
          remoteDataSource: getIt<BoardRemoteDataSource>(),
          networkInfo: getIt<NetworkInfo>()));

  // Register missing use cases required by BoardBloc.
  getIt.registerLazySingleton<GetBoardsUseCase>(
    () => GetBoardsUseCase(getIt<BoardRemoteRepositoryImpl>()),
  );

  getIt.registerLazySingleton<CreateBoardUseCase>(
    () => CreateBoardUseCase(getIt<BoardRemoteRepositoryImpl>()),
  );
  getIt.registerLazySingleton<DeleteBoardUseCase>(
    () => DeleteBoardUseCase(getIt<BoardRemoteRepositoryImpl>()),
  );
  getIt.registerLazySingleton<SyncBoardsUseCase>(
    () => SyncBoardsUseCase(getIt<BoardRemoteRepositoryImpl>()),
  );
  getIt.registerLazySingleton<ToggleFavoriteUseCase>(
    () => ToggleFavoriteUseCase(getIt<BoardRemoteRepositoryImpl>()),
  );
  getIt.registerLazySingleton<UpdateBoardUseCase>(
    () => UpdateBoardUseCase(getIt<BoardRemoteRepositoryImpl>()),
  );
}

_initRegisterDependencies() {
  // =========================== Data Source ===========================
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // getIt.registerLazySingleton<BoardRemoteDataSource>(
  //   () => BoardRemoteDataSource(getIt<Dio>()),
  // );

  // =========================== Repository ===========================
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(getIt<AuthRemoteRepository>()),
  );

  // Register BoardBloc with its required dependencies.
  getIt.registerLazySingleton<BoardBloc>(
    () => BoardBloc(
      getIt<BoardRemoteDataSource>(),
      getBoardsUseCase: getIt<GetBoardsUseCase>(),
      createBoard: getIt<CreateBoardUseCase>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      boardBloc: getIt<BoardBloc>(),
      registerUseCase: getIt<RegisterUsecase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
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
      getIt<AuthRemoteRepository>(),
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

_initSplashScreenDependencies() {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}

// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:vignette__mobile/app/shared_prefs/token_shared_prefs.dart';
// import 'package:vignette__mobile/core/network/api_service.dart';
// import 'package:vignette__mobile/core/network/hive_service.dart';
// import 'package:vignette__mobile/features/auth/data/data_source/auth_remote_data_source/auth_remote_data_source.dart';
// import 'package:vignette__mobile/features/auth/data/data_source/local_data_source.dart/auth_local_datasource.dart'
//     show AuthLocalDatasource;
// import 'package:vignette__mobile/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
// import 'package:vignette__mobile/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
// import 'package:vignette__mobile/features/auth/domain/use_case/login_usecase.dart';
// import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';
// import 'package:vignette__mobile/features/auth/domain/use_case/upload_image_usecase.dart';
// import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:vignette__mobile/features/auth/presentation/view_model/register/register_bloc.dart';
// import 'package:vignette__mobile/features/board/data/data_source/board_data_source.dart';
// import 'package:vignette__mobile/features/board/data/data_source/remote_data_source/board_remote_data_source.dart';
// import 'package:vignette__mobile/features/board/presentation/view_model/board/board_bloc.dart';
// import 'package:vignette__mobile/features/home/presentation/view_model/home_cubit.dart';
// import 'package:vignette__mobile/features/splash/presentation/view_model/splash_cubit.dart';

// final getIt = GetIt.instance;

// Future<void> initDependencies() async {
//   // First initialize hive service
//   await _initHiveService();
//   await _initApiService();
//   await _initSharedPreferences();
//   await _initBoardDependencies();
//   await _initHomeDependencies();
//   await _initRegisterDependencies();
//   await _initLoginDependencies();

//   await _initSplashScreenDependencies();
// }

// Future<void> _initSharedPreferences() async {
//   final sharedPreferences = await SharedPreferences.getInstance();
//   getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
// }

// _initApiService() {
//   // Remote Data Source
//   getIt.registerLazySingleton<Dio>(
//     () => ApiService(Dio()).dio,
//   );
// }

// _initHiveService() {
//   getIt.registerLazySingleton<HiveService>(() => HiveService());
// }

// _initRegisterDependencies() {
// // =========================== Data Source ===========================

//   getIt.registerLazySingleton<AuthLocalDatasource>(
//     () => AuthLocalDatasource(getIt<HiveService>()),
//   );

//   getIt.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSource(getIt<Dio>()),
//   );

//   getIt.registerLazySingleton<BoardRemoteDataSource>(
//     () => BoardRemoteDataSource(getIt<Dio>()),
//   );

//   // =========================== Repository ===========================

//   getIt.registerLazySingleton(
//     () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
//   );
//   getIt.registerLazySingleton<AuthRemoteRepository>(
//     () => AuthRemoteRepository(getIt<AuthRemoteDataSource>()),
//   );

//   // =========================== Usecases ===========================
//   getIt.registerLazySingleton<RegisterUsecase>(
//     () => RegisterUsecase(
//       getIt<AuthRemoteRepository>(),
//     ),
//   );

//   getIt.registerLazySingleton<UploadImageUsecase>(
//     () => UploadImageUsecase(
//       getIt<AuthRemoteRepository>(),
//     ),
//   );

//   getIt.registerLazySingleton<BoardBloc>(() => BoardBloc(
//       getIt<BoardRemoteDataSource>() as IBoardDataSource,
//       getBoardsUseCase: getIt(),
//       createBoard: getIt()));

//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(
//       boardBloc: getIt<BoardBloc>(),
//       registerUseCase: getIt(),
//       uploadImageUsecase: getIt(),
//     ),
//   );
// }

// _initBoardDependencies() {}

// _initHomeDependencies() async {
//   getIt.registerFactory<HomeCubit>(
//     () => HomeCubit(),
//   );
// }

// _initLoginDependencies() async {
//   // =========================== Token Shared Preferences ===========================
//   getIt.registerLazySingleton<TokenSharedPrefs>(
//     () => TokenSharedPrefs(getIt<SharedPreferences>()),
//   );

//   // =========================== Usecases ===========================
//   getIt.registerLazySingleton<LoginUseCase>(
//     () => LoginUseCase(
//       getIt<TokenSharedPrefs>(),
//       getIt<AuthRemoteRepository>(),
//       repository: getIt<AuthRemoteRepository>(),
//     ),
//   );

//   getIt.registerFactory<LoginBloc>(
//     () => LoginBloc(
//       registerBloc: getIt<RegisterBloc>(),
//       homeCubit: getIt<HomeCubit>(),
//       loginUseCase: getIt<LoginUseCase>(),
//     ),
//   );
// }

// _initSplashScreenDependencies() async {
//   getIt.registerFactory<SplashCubit>(
//     () => SplashCubit(getIt<LoginBloc>()),
//   );
// }
