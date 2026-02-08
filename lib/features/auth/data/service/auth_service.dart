import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/features/auth/domain/errors/auth_exceptions.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:connectly_app/features/profile/presentation/views/helper/profile_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance ;

  Future<UserModel> register(
      {required String email,
      required String password,
      required String name,
      required File imageFile,
      }) async {
    // step 1 : auth
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    // step 2 : add user
    final userId = userCredential.user!.uid; // fetch user id
    // upload file to supbase and return url from this func
    String profilePictureUrl = await uploadImageToSupabase(imageFile: imageFile, uid: userId);
    
    final userModel = UserModel(   // create userModel to add it to firebase
        id: userId,
        name: name,
        email: email,
        bio: "",
        profilePictureUrl: profilePictureUrl,
        isOnline: true,
        createdAt: DateTime.now(),
        lastSeen: DateTime.now(),
        fcmToken: null,
        );
      await firebaseFirestore.collection("users").doc(userId).set(userModel.toJson()); // add model to firestore
      return userModel;
  }

  Future<UserModel> login(
      {required String email, required String password}) async {
        // step 1 : auth
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
        // step 2 : get user data
    final userId = userCredential.user!.uid; // fetch doc id
    final userDoc = await firebaseFirestore.collection("users").doc(userId).get(); // get the data
    if(!userDoc.exists){
      throw AuthException("User data not found in database");
    }
    final userModel = UserModel.fromJson(userDoc.data()!);
    await firebaseFirestore.collection("users").doc(userId).update({"isOnline" : true}); // update user state to be true
    return userModel ;
  }

  Future<void> logOut() async{
    try {
  final userId = firebaseAuth.currentUser?.uid;
  if(userId != null){
    await firebaseFirestore.collection("users").doc(userId).update({"isOnline" : false , "lastSeen" : FieldValue.serverTimestamp()}); // update user state to be false
  }
  await firebaseAuth.signOut();
} catch (e) {
  throw Exception('Logout failed: $e');
}
    
  }

  bool isEmailVerified() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

  bool loggedIn() {
    return firebaseAuth.currentUser != null;
  }

  Future<void> sendEmailVerification() async {
    await firebaseAuth.currentUser?.sendEmailVerification();
  }


  Future<void> forgetPassword({required String email}) async {
  try {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw UserNotFoundException();
    } else if (e.code == 'invalid-email') {
      throw AuthException('Invalid email address');
    }
    throw AuthException(e.message ?? 'Failed to send reset email');
  }
}

String currentUserId() {
  return firebaseAuth.currentUser!.uid;
}

User? get getCurrentUser{
  return firebaseAuth.currentUser;
}
}
