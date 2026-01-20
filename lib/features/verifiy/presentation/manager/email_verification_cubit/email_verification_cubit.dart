import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit(this.authRepo)
      : super(EmailVerificationInitialState());

  final AuthRepo authRepo;

  Future<void> sendVerificationEmail() async {
    emit(EmailVerificationLoadingState());
    try {
      if (authRepo.getCurrentUser() == null) {
        emit(EmailVerificationFailure(
            errMessage: "No user is currently signed in"));
            return;
      }
      final isVerified = await authRepo.isEmailVerified();
      if (!isVerified) {
        await authRepo.sendEmailVerification();
      }
      emit(EmailVerificationSentState());
    } catch (e) {
      emit(EmailVerificationFailure(errMessage: e.toString()));
    }
  }
}
