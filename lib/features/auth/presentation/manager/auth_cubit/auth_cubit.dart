import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectly_app/core/service/notification_service.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:connectly_app/features/auth/domain/errors/auth_exceptions.dart';
import 'package:connectly_app/features/profile/data/repo/user_repo.dart';
import 'package:connectly_app/features/profile/presentation/manager/user_cubit/user_cubit.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo, {required this.userCubit, required this.userRepo})
      : super(AuthInitialState());

  final AuthRepo authRepo;
  final UserCubit userCubit;
  final UserRepo userRepo;

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());

    try {
      final userModel = await authRepo.login(email: email, password: password);
      final notificationService = NotificationService();
      await notificationService.requestPermission();
      await notificationService.saveToken(userModel.id);
      notificationService.listenToTokenRefresh(userModel.id);
      notificationService.listenToForegroundMessages();
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
      final notificationService = NotificationService();
      await notificationService.requestPermission();
      await notificationService.saveToken(userModel.id);
      notificationService.listenToTokenRefresh(userModel.id);
      notificationService.listenToForegroundMessages();
      userCubit.setUser(userModel);
      await authRepo.sendEmailVerification();
      emit(EmailNotVerifiedState());
    } on AuthException catch (e) {
      emit(AuthFailureState(errMessage: e.message));
    } on Exception catch (e) {
      if (e.toString().contains('Storage')) {
        emit(AuthFailureState(errMessage: 'Failed to upload profile image'));
      } else {
        emit(AuthFailureState(
            errMessage: 'Registration failed. Please try again.'));
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
    if (authRepo.isEmailVerified()) {
      emit(AuthSuccessState());
    }
  }

  Future<void> checkAuthState() async {
    if (authRepo.loggedIn() && authRepo.isEmailVerified()) {
      emit(AuthSuccessState());
    } else {
      emit(GoToLoginView());
    }
  }

  Future<void> initAfterSplash() async {
  try {
    final firebaseUser = authRepo.currentUser();
    
    if (firebaseUser == null) {
      emit(GoToLoginView());
      return;
    }

    if (!authRepo.isEmailVerified()) {
      emit(EmailNotVerifiedState());
      return;
    }

    final userModel = await userRepo.getUserModelById(firebaseUser.uid);
    
    if (userModel == null) {
      await authRepo.logOut();
      emit(GoToLoginView());
      return;
    }

    userCubit.setUser(userModel);

    // ✅ إعداد Notifications
    final notificationService = NotificationService();
    await notificationService.requestPermission();
    
    // ✅ جلب الـ token
    final token = await notificationService.getFcmToken();
    print("📱 FCM Token: $token"); // Debug
    
    // ✅ حفظ الـ token
    await notificationService.saveToken(firebaseUser.uid);
    
    notificationService.listenToTokenRefresh(firebaseUser.uid);
    notificationService.listenToForegroundMessages();

    emit(AuthSuccessState());
  } catch (e) {
    print('❌ Error in initAfterSplash: $e');
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

  Future<void> forgetPassword({required String email}) async {
    try {
      await authRepo.forgetPassword(email: email);
      emit(ForgetPasswordState());
    } catch (e) {
      emit(ForgetPasswordFailureState(errMessage: e.toString()));
    }
  }

  String currentUserId() {
    return authRepo.currentUserId();
  }
}
