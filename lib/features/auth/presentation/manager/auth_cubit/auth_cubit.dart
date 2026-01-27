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
        if( authRepo.isEmailVerified()){
          emit(AuthSuccessState());
        }
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
        await authRepo.sendEmailVerification();
      emit(EmailNotVerifiedState());
    } on AuthException catch (e) {
    emit(AuthFailureState(errMessage: e.message));
  }catch (e) {
      emit(AuthFailureState(errMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> logout() async {
    await authRepo.logOut();
    emit(AuthLoggedOutState());
  }

  Future<void> checkVerification() async {
    if ( authRepo.isEmailVerified()) {
      emit(AuthSuccessState());
    }
  }

  Future<void> checkAuthState()async{
    if ( authRepo.isEmailVerified() && authRepo.loggedIn()) {
      emit(AuthSuccessState());
    }
  }

  Future<void> resendVerificationEmail() async {
  try {
    await authRepo.sendEmailVerification();
  } catch (e) {
    emit(AuthFailureState(errMessage: e.toString()));
  }
}

  Future<void> forgetPassword({required String email})async{
    try {
  await authRepo.forgetPassword(email: email);
  emit(ForgetPasswordState());
} catch (e) {
  emit(ForgetPasswordFailureState(errMessage: e.toString()));
}
  }
}
