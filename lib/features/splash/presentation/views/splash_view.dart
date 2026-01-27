import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/app_colors.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.deepPrimary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if(state is AuthSuccessState){
                context.go(AppRouter.homeView);
              }else if (state is GoToLoginView){
                context.go(AppRouter.loginView);
              }
            },
            child: SplashViewBody(),
          )),
    );
  }
}
