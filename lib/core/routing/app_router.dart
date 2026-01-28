import 'dart:async';
import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/presentation/views/login_view.dart';
import 'package:connectly_app/features/auth/presentation/views/register_view.dart';
import 'package:connectly_app/features/home/presentation/views/home_view.dart';
import 'package:connectly_app/features/profile/presentation/views/profile_view.dart';
import 'package:connectly_app/features/splash/presentation/views/splash_view.dart';
import 'package:connectly_app/features/verifiy/presentation/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String splashView = '/';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String homeView = '/home';
  static const String verifyView = '/verify';
  static const String profileView = '/profile';

  static final GoRouter router = GoRouter(
    initialLocation: splashView,
    routes: [
      GoRoute(
        path: splashView,
        builder: (_, __) => const SplashView(),
      ),
      GoRoute(
        path: loginView,
        builder: (_, __) => const LoginView(),
      ),
      GoRoute(
        path: registerView,
        builder: (_, __) => const RegisterView(),
      ),
      GoRoute(
          path: verifyView,
          builder: (context, state) {
            return VerifyEmailView();
          }),
      GoRoute(
        path: homeView,
        builder: (context, state) {
          return HomeView();
        },
      ),
      GoRoute(
        path: profileView,
        builder: (context, state) {
          return ProfileView();
        },
      ),
    ],
  );
}
