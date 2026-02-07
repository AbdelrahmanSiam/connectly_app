import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:connectly_app/features/profile/data/repo/user_repo.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepo) : super(UserInitialState());
final UserRepo userRepo;
  void setUser(UserModel userModel){
    emit(UserSuccessState(userModel: userModel));
  }

  void clearUser(){
    emit(UserInitialState());
  }
  
  void updateUser({ String ? name , String ? bio , String ? profilePictureUrl }){
    final currentState  = state ;
    if(currentState is UserSuccessState){
      final updatedState = currentState.copyWith(
        name: name,
        bio: bio,
        profilePictureUrl: profilePictureUrl,
      );
      
      emit(updatedState);
    } else {
      print('❌ UserCubit: Cannot update - no user loaded');
    }
  }

  UserModel? get currentUser {
    final currentState = state;
    
    if (currentState is UserSuccessState) {
      return currentState.userModel;
    }
    
    return null;
  } // to get current user

    bool get isUserLoaded => state is UserSuccessState; // check there user or not

  Future<int> getUserStats({required String userId})async{
    final chatCount = await userRepo.getChatsCount(userId: userId);
    return chatCount;
  }

  Future<void> getUserData({required String userId}) async {
    try {      
      final userModel = await userRepo.getUserModelById(userId);
      
      if (userModel != null) {
        print('✅ UserCubit: User data loaded successfully');
        emit(UserSuccessState(userModel: userModel));
      } else {
        print('❌ UserCubit: User not found');
        emit(UserFailureState(errMessage: 'User not found'));
      }
    } catch (e) {
      print('❌ UserCubit: Error loading user data - $e');
      emit(UserFailureState(errMessage: e.toString()));
    }
  }
}
