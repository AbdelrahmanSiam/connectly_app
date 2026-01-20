import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:connectly_app/features/auth/data/service/auth_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance; // This is our global ServiceLocator

void setupLocator() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authService: getIt<AuthService>()),
  );

}
