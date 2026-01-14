part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class HomeLoadingState extends HomeState {}

final class HomeSuccessState extends HomeState {
  final List<UserModel> userModelList;

  HomeSuccessState({required this.userModelList});
}

final class HomeFailureState extends HomeState {
  final String errMessage;

  HomeFailureState({required this.errMessage});
}
