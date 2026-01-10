import 'package:connectly/features/auth/presentation/views/login_view.dart';
import 'package:connectly/features/auth/presentation/views/register_view.dart';
import 'package:connectly/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String splashView = '/';
  static const String loginView = '/loginView';
  static const String registerView = '/registerView';
  static final  GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: splashView,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: loginView,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: registerView,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterView();
        },
      ),
    ],
  );
}
