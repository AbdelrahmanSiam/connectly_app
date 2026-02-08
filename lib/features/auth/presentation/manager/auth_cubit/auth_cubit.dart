import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/domain/errors/auth_exceptions.dart';
import 'package:connectly_app/features/profile/presentation/manager/user_cubit/user_cubit.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo, {required this.userCubit}) : super(AuthInitialState());

  final AuthRepo authRepo;
  final UserCubit userCubit;

  
  Future<void> login({required String email, required String password}) async {
  emit(AuthLoadingState());
  
  try {
    final userModel = await authRepo.login(email: email, password: password);
    
    userCubit.setUser(userModel);

    if (!authRepo.isEmailVerified()) {
      emit(EmailNotVerifiedState());
      return;
    }

    emit(AuthSuccessState());
  } on AuthException catch (e) {
    emit(AuthFailureState(errMessage: e.message));
  } catch (e) {
    emit(AuthFailureState(errMessage: 'An unexpected error occurred'));
  }
}

  Future<void> register({
  required String email,
  required String password,
  required String name,
  required File imageFile,
}) async {
  emit(AuthLoadingState());
  try {
    final userModel = await authRepo.register(
      email: email,
      password: password,
      name: name,
      imageFile: imageFile,
    );
    userCubit.setUser(userModel);
    await authRepo.sendEmailVerification();
    emit(EmailNotVerifiedState());
  } on AuthException catch (e) {
    emit(AuthFailureState(errMessage: e.message));
  } on Exception catch (e) {
    if (e.toString().contains('Storage')) {
      emit(AuthFailureState(errMessage: 'Failed to upload profile image'));
    } else {
      emit(AuthFailureState(errMessage: 'Registration failed. Please try again.'));
    }
  } catch (e) {
    emit(AuthFailureState(errMessage: 'An unexpected error occurred'));
  }
}

  Future<void> logout() async {
    emit(LogoutLoadingState());
    await authRepo.logOut();
    userCubit.clearUser();
      print('✅ AuthCubit: User cleared from UserCubit');
    emit(AuthLoggedOutState());
  }

  Future<void> checkVerification() async {
    if ( authRepo.isEmailVerified()) {
      emit(AuthSuccessState());
    }
  }

  Future<void> checkAuthState()async{
    if ( authRepo.loggedIn() && authRepo.isEmailVerified()) {
      emit(AuthSuccessState());
    }else{
      emit(GoToLoginView());
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

  String currentUserId() {
    return  authRepo.currentUserId();
  }
}
