import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/auth/data/service/auth_service.dart';
import 'package:connectly_app/features/auth/presentation/views/login_view.dart';
import 'package:connectly_app/features/auth/presentation/views/register_view.dart';
import 'package:connectly_app/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String splashView = '/';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String homeView = '/home';


  static final GoRouter router = GoRouter(
    initialLocation: AppRouter.splashView,
    redirect: (context, state) {
      final authService = getIt.get<AuthService>();
      final isLoggedIn = authService.isLoggedIn();
      final isAuthRoute =
          state.uri.path == loginView || state.uri.path == registerView;
      final isSplash = state.uri.path == splashView;

      if (isSplash) return null;
      if (!isLoggedIn && !isAuthRoute) {
        return AppRouter.loginView;
      }
      if (isLoggedIn && isAuthRoute) {
        return AppRouter.homeView;
      }
      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: splashView,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
          path: loginView,
          builder: (context, state) {
            return LoginView();
          }),
      GoRoute(
        path: registerView,
        builder: (context, state) {
          return RegisterView();
        },
      ),
      
    ],
  );
}
