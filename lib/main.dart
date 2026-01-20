import 'package:connectly_app/core/routing/app_router.dart';
import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly_app/features/auth/presentation/manager/email_verification_cubit/email_verification_cubit.dart';
import 'package:connectly_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthRepo>())),
        BlocProvider(create: (context) => EmailVerificationCubit(getIt.get<AuthRepo>())),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0XFF141414),
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
