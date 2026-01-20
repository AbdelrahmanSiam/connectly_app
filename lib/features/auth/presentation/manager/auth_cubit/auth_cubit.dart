import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/domain/errors/auth_exceptions.dart';
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
        await authRepo.login(email: email, password: password);

    emit(AuthSuccessState());
  } on AuthException catch (e) {
    emit(AuthFailureState(errMessage: e.message));
  }catch (e) {
      emit(AuthFailureState(errMessage: 'An unexpected error occurred'));
    }
}


  Future<void> register(
      {required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
       await authRepo.register(email: email, password: password);
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailureState(errMessage: 'An unexpected error occurred'));
    } 
  }

  Future<void> logout() async {
    await authRepo.logOut();
    emit(AuthLoggedOutState());
  }
}
