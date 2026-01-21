import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<UserCredential> register(
      {required String email, required String password});

  Future<UserCredential> login(
      {required String email, required String password});

  Future<void> logOut();

  Future<void> deletAccount();
  
  bool isEmailVerified() ;

  Future<void> sendEmailVerification();

  Future<void> forgetPassword({required String email});
}
