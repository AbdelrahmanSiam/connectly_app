import 'dart:async';

import 'package:connectly_app/core/cubit/auth_state_cubit/auth_state_cubit.dart';
import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/auth/presentation/views/login_view.dart';
import 'package:connectly_app/features/auth/presentation/views/register_view.dart';
import 'package:connectly_app/features/splash/presentation/views/splash_view.dart';
import 'package:connectly_app/features/verifiy/presentation/views/verify_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String splashView = '/';
  static const String loginView = '/login';
  static const String registerView = '/register';
  static const String homeView = '/home';
  static const String verifiyView = '/verifiy';

  static final GoRouter router = GoRouter(
    initialLocation: splashView,
    refreshListenable: GoRouterRefreshStream(getIt<AuthStateCubit>().stream),
    redirect: (context, state) {
      final authState = getIt<AuthStateCubit>().state;

      final isAuthRoute = state.uri.path == loginView || state.uri.path == registerView;
      final isSplash = state.uri.path == splashView;

      if (isSplash) return null;

      if (authState is UnauthenticatedState && !isAuthRoute) {
        return loginView;
      }

      if (authState is AuthenticatedVerifiedState && isAuthRoute) {
        return homeView;
      }

      if (authState is AuthenticatedNotVerifiedState && isAuthRoute) {
        return verifiyView;
      }

      return null;
    },
    routes: [
      GoRoute(path: splashView, builder: (_, __) => const SplashView()),
      GoRoute(path: loginView, builder: (_, __) => const LoginView()),
      GoRoute(path: registerView, builder: (_, __) => const RegisterView()),
      GoRoute(path: verifiyView, builder: (_, __) => const VerifyEmailView()),
    ],
  );
}


/// Makes GoRouter listen to any Stream of events and refreshes the router
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((event) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
