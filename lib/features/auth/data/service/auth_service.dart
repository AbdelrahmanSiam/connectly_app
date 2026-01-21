import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> register(
      {required String email, required String password}) async {
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> login(
      {required String email, required String password}) async {
    return await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
  }


  Future<void> logOut() {
    return firebaseAuth.signOut();
  }

  bool isEmailVerified() {
        return firebaseAuth.currentUser!.emailVerified ;
  }
  Future<void> sendEmailVerification() async {
    await firebaseAuth.currentUser?.sendEmailVerification();
  }

  Future<void> deleteAccount() async {
    await firebaseAuth.currentUser?.delete();
  }

  Future<void> forgetPassword({required String email})async{
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
