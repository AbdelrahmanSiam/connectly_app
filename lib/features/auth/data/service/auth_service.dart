import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // register method
  Future<UserCredential> register(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }
  // login method
  Future<UserCredential> login(
      {required String email, required String password}) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
  // to return current user
  User? getCurrentUser(){
    return firebaseAuth.currentUser;
  }

  // logged out
  Future<void> logOut(){
    return firebaseAuth.signOut();
  }
  // email verification
  Future<bool> isEmailVerified() async {
    await firebaseAuth.currentUser!.reload();
    return firebaseAuth.currentUser!.emailVerified;
  }
  Future<void>sendEmailVerification()async{
    await firebaseAuth.currentUser!.sendEmailVerification();
  }
}
