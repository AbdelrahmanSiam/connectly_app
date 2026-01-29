part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitialState extends UserState {}
final class UserLoadingState extends UserState {}
final class UserSuccessState extends UserState {
  final UserModel userModel;

  UserSuccessState({required this.userModel});

  // mehtod for update
  UserSuccessState copyWith({
    String? name,
    String? bio,
    String? profilePictureUrl,
    bool? isOnline,
  }) {
    return UserSuccessState(userModel: 
      UserModel(
        id: userModel.id,
        name: name ?? userModel.name,
        email: userModel.email,
        profilePictureUrl: profilePictureUrl ?? userModel.profilePictureUrl,
        bio: bio ?? userModel.bio,
        isOnline: isOnline ?? userModel.isOnline,
        createdAt: userModel.createdAt,
        lastSeen: userModel.lastSeen,
      ),
    );
  }
}
final class UserFailureState extends UserState {
  final String errMessage;

  UserFailureState({required this.errMessage});
}
