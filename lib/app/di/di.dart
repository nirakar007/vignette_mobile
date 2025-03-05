import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vignette__mobile/app/services/user_service.dart';
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
import 'package:vignette__mobile/features/auth/data/repository/auth_repository_impl.dart';
import 'package:vignette__mobile/features/auth/domain/repository/auth_repository.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/login_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/logout_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:vignette__mobile/features/auth/presentation/view_model/logout/logout_bloc.dart';
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
  await _initLoginDependencies();
  await _initRegisterDependencies();
  await _initLogoutDependencies();
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

// =========================== Register ===========================

_initRegisterDependencies() async {
  // =========================== Data Source ===========================

  // 1. Open Hive Box *before* registering
  final sharedTokenBox = await getIt<HiveService>()
      .openBox('SharedToken'); // Open and await the box

  // 2. Register the opened Hive Box as a lazy singleton
  getIt.registerLazySingleton<Box<dynamic>>(
    () => sharedTokenBox, // Return the already opened box instance
    instanceName: 'SharedToken',
  );

  // 3. Register AuthLocalDatasource with correct dependencies
  getIt.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(
      getIt<HiveService>(), // First parameter (HiveService)
      getIt<
          SharedPreferences>(), // Second parameter (SharedPreferences) - Corrected
    ),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton<IAuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: getIt<AuthRemoteDataSource>(),
        localDataSource: getIt<AuthLocalDatasource>(),
      ));

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
      // Remove loginBloc from the constructor
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
  getIt.registerLazySingleton<UserService>(() => UserService(getIt<Dio>()));
}

// =========================== Login ===========================

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<LoginUseCase>(() => LoginUseCase(
        repository: getIt<IAuthRepository>(), // Inject AuthRepository
        tokenSharedPrefs: getIt<TokenSharedPrefs>(), // Inject TokenSharedPrefs
      ));

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

// =========================== Logout ===========================

_initLogoutDependencies() async {
  // In your DI configuration
  getIt.registerFactory(() => LogoutBloc(logoutUseCase: getIt()));
  getIt.registerFactory(() => LogoutUseCase(repository: getIt()));
}

// =========================== Splash ===========================

_initSplashScreenDependencies() {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<LoginBloc>()),
  );
}
