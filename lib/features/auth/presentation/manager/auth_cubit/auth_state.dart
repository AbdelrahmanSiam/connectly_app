part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {}

final class AuthLoggedOutState extends AuthState {}

final class ForgetPasswordState extends AuthState {}

final class ForgetPasswordFailureState extends AuthState {
  final String errMessage;

  ForgetPasswordFailureState({required this.errMessage});
}

final class AuthFailureState extends AuthState {
  final String errMessage;

  AuthFailureState({required this.errMessage});
}
final class EmailNotVerifiedState extends AuthState {}

