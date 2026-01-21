import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class Verifiedbutton extends StatelessWidget {
  const Verifiedbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
          onPressed:() {
                  BlocProvider.of<AuthCubit>(context).checkVerification();
                },
          child: const Text('I Verified My Email'),
        );
  }
}
