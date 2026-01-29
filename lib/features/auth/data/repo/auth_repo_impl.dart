import 'dart:io';

import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/data/service/auth_service.dart';
import 'package:connectly_app/features/auth/domain/errors/auth_exceptions.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl({required this.authService});
  @override
  Future<UserModel> login(
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
  Future<UserModel> register(
      {required String email, required String password , required String name}) async {
        try{
    return await authService.register(email: email, password: password , name: name);
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
  bool isEmailVerified(){
    return authService.isEmailVerified();
  }
  
  
  @override
  Future<void> logOut() async {
   return await authService.logOut();
  }
  
  @override
Future<void> sendEmailVerification() async {
  try {
    await authService.sendEmailVerification();
  } catch (e) {
    throw AuthException('Failed to send verification email: $e');
  }
}
  

  
  @override
  Future<void> deletAccount()async {
    try {
  await authService.deleteAccount();
} catch (e) {
  throw Exception('Failed to delete account: $e');
}
  }
  
  @override
  Future<void> forgetPassword({required String email}) async{
  await authService.forgetPassword(email: email);

  }
  
  @override
  bool loggedIn() {
    return authService.loggedIn();
  }
    
  }


