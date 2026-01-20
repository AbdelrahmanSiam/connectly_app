import 'dart:io';

import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/data/service/auth_service.dart';
import 'package:connectly_app/features/auth/domain/errors/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl({required this.authService});
  @override
  Future<UserCredential> login(
      {required String email, required String password}) async {
        try{
    return await authService.login(email: email, password: password);
        }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else if (e.code == 'network-request-failed') {
        throw NetworkException();
      } else {
        throw AuthException(e.message ?? 'An error occurred');
      }
    } on SocketException {
      throw NetworkException();
    }
  }

  @override
  Future<UserCredential> register(
      {required String email, required String password}) async {
        try{
    return await authService.register(email: email, password: password);
        }on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw EmailAlreadyIsUsedException();
      } else if (e.code ==  'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'network-request-failed') {
        throw NetworkException();
      } else {
        throw AuthException(e.message ?? 'An error occurred');
      }
    } on SocketException {
      throw NetworkException();
    }
  }
  
  @override
  User? getCurrentUser() {
    return authService.getCurrentUser();
  }
  
  @override
  bool isEmailVerified() {
    return  authService.emailIsVerified();
  }
  
  @override
  bool isLogged() {
    return authService.isLoggedIn();
  }
  
  @override
  Future<void> logOut() async {
   return await authService.logOut();
  }
  }


