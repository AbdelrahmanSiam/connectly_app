part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final String? uid , email;

  AuthSuccessState({required this.uid,required  this.email});
}

final class AuthLoggedInState extends AuthState {
  final String? uid , email;

  AuthLoggedInState({required this.uid,required  this.email});
}

final class AuthLoggedOutState extends AuthState {}

final class AuthFailureState extends AuthState {
  final String errMessage;

  AuthFailureState({required this.errMessage});
}
