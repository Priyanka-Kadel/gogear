// import 'package:get_it/get_it.dart';

// import '../../core/network/hive_service.dart';
// import '../../features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
// import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
// import '../../features/auth/domain/use_case/login_usecase.dart';
// import '../../features/auth/domain/use_case/register_user_usecase.dart';
// import '../../features/auth/presentation/view_model/login/login_bloc.dart';
// import '../../features/auth/presentation/view_model/signup/register_bloc.dart';
// import '../../features/home/presentation/view_model/home_cubit.dart';
// import '../../features/splash/presentation/view_model/splash_cubit.dart';

// final getIt = GetIt.instance;

// Future<void> initDependencies() async {
//   // First initialize hive service
//   await _initHiveService();
//   await _initHomeDependencies();
//   await _initRegisterDependencies();
//   await _initLoginDependencies();

//   await _initSplashScreenDependencies();
// }

// _initHiveService() {
//   getIt.registerLazySingleton<HiveService>(() => HiveService());
// }

// _initRegisterDependencies() {
//   // init local data source
//   getIt.registerLazySingleton(
//     () => AuthLocalDataSource(getIt<HiveService>()),
//   );

//   // init local repository
//   getIt.registerLazySingleton(
//     () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
//   );

//   // register use usecase
//   getIt.registerLazySingleton<RegisterUseCase>(
//     () => RegisterUseCase(
//       getIt<AuthLocalRepository>(),
//     ),
//   );

//   getIt.registerFactory<RegisterBloc>(
//     () => RegisterBloc(
//       registerUseCase: getIt(),
//     ),
//   );
// }

// _initHomeDependencies() async {
//   getIt.registerFactory<HomeCubit>(
//     () => HomeCubit(),
//   );
// }

// _initLoginDependencies() async {
//   getIt.registerLazySingleton<LoginUseCase>(
//     () => LoginUseCase(
//       getIt<AuthLocalRepository>(),
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

import 'package:gear_rental/features/auth/data/data_source/local_data_source/auth_local_datasource.dart';
import 'package:gear_rental/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:gear_rental/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:get_it/get_it.dart';

import '../../core/network/hive_service.dart';
import '../../features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import '../../features/auth/domain/use_case/login_usecase.dart';
import '../../features/auth/presentation/view_model/login/login_bloc.dart';
import '../../features/auth/presentation/view_model/signup/register_bloc.dart';
import '../../features/home/presentation/view_model/home_cubit.dart';
import '../../features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // Initialize Hive service
  await _initHiveService();

  // Initialize all feature-specific dependencies
  await _initHomeDependencies();
  await _initLoginDependencies();
  await _initRegisterDependencies();
  await _initSplashScreenDependencies();
  await _initOnboardingDependencies();
}

// Initialize HiveService
Future<void> _initHiveService() async {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
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

// Initialize Home Feature Dependencies
Future<void> _initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(() => HomeCubit());
}

Future<void> _initOnboardingDependencies() async {
  getIt.registerFactory<OnboardingCubit>(
      () => OnboardingCubit(getIt<LoginBloc>()));
}

// Initialize Splash Screen Dependencies
Future<void> _initSplashScreenDependencies() async {
  getIt.registerFactory<SplashCubit>(
    () => SplashCubit(getIt<OnboardingCubit>()),
  );
}
