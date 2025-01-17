import 'package:get_it/get_it.dart';
import 'package:vignette__mobile/core/network/hive_service.dart';
import 'package:vignette__mobile/features/auth/data/data_source/local_data_source.dart/auth_local_datasource.dart';
import 'package:vignette__mobile/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:vignette__mobile/features/auth/domain/use_case/register_usecase.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initRegisterDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDatasource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDatasource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(
      getIt<AuthLocalRepository>(),
    ),
  );

  // getIt.registerFactory<RegisterBloc>(
  //   () => RegisterBloc(
  //     batchBloc: getIt<BatchBloc>(),
  //     courseBloc: getIt<Course1Bloc>(),
  //     registerUseCase: getIt(),
  //   ),
  // );
}
