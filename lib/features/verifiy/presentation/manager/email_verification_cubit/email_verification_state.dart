part of 'email_verification_cubit.dart';

@immutable
sealed class EmailVerificationState {}

final class EmailVerificationInitialState extends EmailVerificationState {}
final class EmailVerificationLoadingState extends EmailVerificationState {}
final class EmailVerificationSentState extends EmailVerificationState {}
final class EmailVerificationFailure extends EmailVerificationState {
  final String errMessage;

  EmailVerificationFailure({required this.errMessage});
}

