import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  EmailVerificationCubit(this.authRepo) : super(EmailVerificationInitialState());

  final AuthRepo authRepo;

  Future<void>sendVerificationEmail()async{
    emit(EmailVerificationLoadingState());
    try{
      await authRepo.sendEmailVerification();
      emit(EmailVerificationSuccessState());
    }catch(e){
      emit(EmailVerificationFailure(errMessage: e.toString()));
    }
  }

  Future<void> checkVerification()async{
    emit(EmailVerificationLoadingState());
    try {
  if(await authRepo.isEmailVerified()){
    emit(EmailVerificationVerified());
  }
  else{
    emit(EmailVerificationNotVerified());
  }
} catch (e) {
  emit(EmailVerificationFailure(errMessage: e.toString()));
}
}
}
