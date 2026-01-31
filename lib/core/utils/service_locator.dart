import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:connectly_app/features/auth/data/service/auth_service.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/profile/data/repo/user_repo.dart';
import 'package:connectly_app/features/profile/data/repo/user_repo_impl.dart';
import 'package:connectly_app/features/profile/data/service/user_service.dart';
import 'package:connectly_app/features/profile/presentation/manager/user_cubit/user_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance; // This is our global ServiceLocator

void setupLocator() {
  getIt.registerLazySingleton<UserService>(() => UserService());
  getIt.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(userService: getIt()));
  getIt.registerLazySingleton<UserCubit>(
    () => UserCubit(getIt()),
  );
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(authService: getIt()));
  getIt.registerLazySingleton<AuthCubit>(
      () => AuthCubit(getIt(), userCubit: getIt<UserCubit>()));
}
