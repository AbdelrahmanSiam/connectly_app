import 'package:connectly/features/auth/data/repo/auth_repo.dart';
import 'package:connectly/features/auth/data/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl({required this.authService});
  @override
  Future<UserCredential> login(
      {required String email, required String password}) async {
    return await authService.login(email: email, password: password);
  }

  @override
  Future<UserCredential> register(
      {required String email, required String password}) async {
    return await authService.register(email: email, password: password);
  }

  @override
  Future<bool> isLogged() async {
    return authService.isLoggedIn();
  }
}
