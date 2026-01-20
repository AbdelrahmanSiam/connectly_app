import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_state_state.dart';

class AuthStateCubit extends Cubit<AuthStateState> {
  AuthStateCubit(this.authRepo) : super(AuthStateInitialState());

  final AuthRepo authRepo;
  Future<void> checkAuthStatus() async {
    final user = authRepo.getCurrentUser();
    if (user == null) {
      emit(UnauthenticatedState());
      return;
    }

    final verified = await authRepo.isEmailVerified();
    if (verified) {
      emit(AuthenticatedVerifiedState());
    } else {
      emit(AuthenticatedNotVerifiedState());
    }
  }

  Future<void> logout() async {
    await authRepo.logOut();
    emit(UnauthenticatedState());
  }
}
