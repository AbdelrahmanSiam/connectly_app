import 'package:connectly_app/core/cubit/auth_state_cubit/auth_state_cubit.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:connectly_app/features/auth/data/service/auth_service.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/verifiy/presentation/manager/email_verification_cubit/email_verification_cubit.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance; // This is our global ServiceLocator

void setupLocator() {
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(authService: getIt()));
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit(getIt()));
  getIt.registerLazySingleton<EmailVerificationCubit>(() => EmailVerificationCubit(getIt()));
  getIt.registerLazySingleton<AuthStateCubit>(() => AuthStateCubit(getIt()));
}
