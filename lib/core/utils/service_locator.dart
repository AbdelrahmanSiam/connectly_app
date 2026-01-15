import 'package:connectly/features/auth/data/repo/auth_repo.dart';
import 'package:connectly/features/auth/data/repo/auth_repo_impl.dart';
import 'package:connectly/features/auth/data/service/auth_service.dart';
import 'package:connectly/features/home/data/repo/home_repo.dart';
import 'package:connectly/features/home/data/repo/home_repo_implementation.dart';
import 'package:connectly/features/home/data/service/home_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance; // This is our global ServiceLocator

void setupLocator() {
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<HomeService>(HomeService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(authService: getIt<AuthService>()),
  );
  getIt.registerSingleton<HomeRepo>(
    HomeRepoImplementation(homeService: getIt<HomeService>()),
  );
}
