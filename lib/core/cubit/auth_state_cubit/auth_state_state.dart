part of 'auth_state_cubit.dart';

@immutable
sealed class AuthStateState {}

final class AuthStateInitialState extends AuthStateState {}
final class UnauthenticatedState extends AuthStateState {}
final class AuthenticatedNotVerifiedState extends AuthStateState {}
final class AuthenticatedVerifiedState extends AuthStateState {}
