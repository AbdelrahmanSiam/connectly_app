import 'package:bloc/bloc.dart';
import 'package:connectly/features/auth/data/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitialState());

  final AuthRepo authRepo;
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      await authRepo.login(email: email, password: password);
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailureState(errMessage: e.message ?? 'Auth Error'));
    } catch (e) {
      emit(AuthFailureState(errMessage: 'Something went wrong'));
    }
  }

  Future<void> register({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      await authRepo.register(email: email, password: password);
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailureState(errMessage: e.message ?? 'Auth Error'));
    } catch (e) {
      emit(AuthFailureState(errMessage: 'Something went wrong'));
    }
  }
}
