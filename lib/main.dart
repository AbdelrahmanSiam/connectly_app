import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepoImpl>()),
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
      ),
    );
  }
}
