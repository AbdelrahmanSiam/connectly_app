import 'dart:io';

import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<UserModel> register(
      {required String email, required String password , required String name , required File imageFile,});

  Future<UserModel> login(
      {required String email, required String password});

  Future<void> logOut();

  Future<void> deletAccount();
  
  bool isEmailVerified() ;

  bool loggedIn() ;

  Future<void> sendEmailVerification();

  Future<void> forgetPassword({required String email});
}
