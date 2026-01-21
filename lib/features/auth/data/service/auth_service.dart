import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // register method
  Future<UserCredential> register(
      {required String email, required String password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  // login method
  Future<UserCredential> login(
      {required String email, required String password}) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
  }


  // logged out
  Future<void> logOut() {
    return firebaseAuth.signOut();
  }

  // email verification
  bool isEmailVerified() {
        return firebaseAuth.currentUser!.emailVerified ;
  }
  // send email verification message
  Future<void> sendEmailVerification() async {
    await firebaseAuth.currentUser?.sendEmailVerification();
  }

   // Delete account
  Future<void> deleteAccount() async {
    await firebaseAuth.currentUser?.delete();
  }
}
