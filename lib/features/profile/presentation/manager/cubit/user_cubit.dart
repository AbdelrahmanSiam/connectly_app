import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());

  void setUser(UserModel userModel){
    emit(UserSuccessState(userModel: userModel));
  }

  void clearUser(){
    emit(UserInitialState());
  }
  
  void updateUser({ String ? name , String ? bio , String ? profilePictureUrl , bool ? isOnline}){
    final currentState  = state ;
    if(currentState is UserSuccessState){
      final updatedState = currentState.copyWith(
        name: name,
        bio: bio,
        profilePictureUrl: profilePictureUrl,
        isOnline: isOnline,
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

}
