part of 'email_verification_cubit.dart';

@immutable
sealed class EmailVerificationState {}

final class EmailVerificationInitialState extends EmailVerificationState {}
final class EmailVerificationLoadingState extends EmailVerificationState {}
final class EmailVerificationSuccessState extends EmailVerificationState {}
final class EmailVerificationFailure extends EmailVerificationState {
  final String errMessage;

  EmailVerificationFailure({required this.errMessage});
}
final class EmailVerificationVerified extends EmailVerificationState {}
final class EmailVerificationNotVerified extends EmailVerificationState {}
