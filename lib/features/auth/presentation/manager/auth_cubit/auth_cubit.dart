import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitialState());

  final AuthRepo authRepo;

  
  Future<void> login({
  required String email,
  required String password,
}) async {
  emit(AuthLoadingState());
  try {
    final userCredential =
        await authRepo.login(email: email, password: password);

    emit(AuthSuccessState(
      uid: userCredential.user!.uid,
      email: userCredential.user!.email,
    ));
  } on FirebaseAuthException catch (e) {
    emit(AuthFailureState(errMessage: _mapError(e)));
  }
}


  Future<void> register(
      {required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final userCredintial = await authRepo.register(email: email, password: password);
      emit(AuthSuccessState(
        uid : userCredintial.user!.uid, // send ui to register to send it to profile view to add it to user collection
        email : userCredintial.user!.email,
      ));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailureState(errMessage: _mapError(e)));
    } 
  }

  Future<void> checkIfLoggedIn() async {
  emit(AuthLoadingState());
  final user = await authRepo.getCurrentUser();

  if (user != null) {
    emit(AuthLoggedInState(
      uid: user.uid,
      email: user.email,
    ));
  } else {
    emit(AuthLoggedOutState());
  }
}

String currentUserId(){
  return authRepo.getCurrentUser()!.uid;
}

  Future<void> logout() async {
    await authRepo.logOut();
    emit(AuthInitialState());
  }
}



String _mapError(dynamic error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'user-not-found':
        return 'No user found for this email';
      case 'wrong-password':
        return 'Wrong password';
      case 'invalid-email':
        return 'Invalid email format';
      default:
        return 'Something went wrong, try again';
    }
  }
  return 'Unexpected error occurred';
}
