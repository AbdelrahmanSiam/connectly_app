import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/features/profile/presentation/manager/user_cubit/user_cubit.dart';
import 'package:connectly_app/features/profile/presentation/views/helper/profile_helper.dart';
import 'package:meta/meta.dart';
part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
   EditProfileCubit(this.userCubit) : super(EditProfileInitialState());
  final UserCubit userCubit;

  Future<void> updateProfile(
      {required String name,
      required String bio,
       File? newProfilePic}) async {
    emit(EditProfileLoadingState());

    try {
      final currentUser = userCubit.currentUser;
      if (currentUser == null) {
        emit(EditProfileFailureState(errMessage: "No user logged in"));
        return;
      }
      String profilePicUrl = currentUser!.profilePictureUrl;
      // Upload selected image to supabase
      if (newProfilePic != null) {
      profilePicUrl = await uploadImageToSupabase(
        imageFile: newProfilePic,
        uid: currentUser.id,
      );
    }
      // update firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.id)
          .update({
        'name': name,
        'bio': bio,
        'profilePictureUrl': profilePicUrl,
      });
      print('✅ ProfileCubit: Profile updated in Firestore');
      // update userCubit
      userCubit.updateUser(
        name: name,
        bio: bio,
        profilePictureUrl: profilePicUrl,
      );
      print('✅ ProfileCubit: UserCubit updated');
      emit(EditProfileSuccessState());
    } catch (e) {
      print('❌ ProfileCubit: Error updating profile - $e');
      emit(EditProfileFailureState(errMessage: e.toString()));
    }
  }
}
