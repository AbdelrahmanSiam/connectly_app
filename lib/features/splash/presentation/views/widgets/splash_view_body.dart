import 'dart:async';
import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/service/notification_service.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/splash/presentation/views/widgets/splash_view_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// statfull because we need time , animation and lifecyle
class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _notificationService.listenToForegroundMessages();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.elasticOut,
      ),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeIn,
      ),
    );

    animationController.forward();

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.read<AuthCubit>().initAfterSplash();
      }
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: const SplashViewIcon(),
        ),
      ),
    );
  }
}
