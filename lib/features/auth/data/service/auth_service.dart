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
  // check if logged in or not
  bool isLoggedIn() {
    return firebaseAuth.currentUser != null;
  }
  // logged out
  Future<void> logOut(){
    return firebaseAuth.signOut();
  }
  // email verification
  bool emailIsVerified(){
    return firebaseAuth.currentUser!.emailVerified;
  }
}
