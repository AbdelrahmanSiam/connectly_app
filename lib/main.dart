import 'package:connectly/core/routing/app_router.dart';
import 'package:connectly/core/utils/service_locator.dart';
import 'package:connectly/features/auth/data/repo/auth_repo.dart';
import 'package:connectly/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:connectly/features/splash/presentation/views/splash_view.dart';
import 'package:connectly/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
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
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepo>()),
      child: MaterialApp.router(
        theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFF121212)),
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
