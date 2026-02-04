import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/home/data/repo/home_repo.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit(this.homeRepo) : super(CreateChatInitialState());
  final HomeRepo homeRepo;
  String myId = FirebaseAuth.instance.currentUser!.uid;
  StreamSubscription? usersSub;

// 1- load availble users 
  void loadUsers() {
    emit(CreateChatLoadingState());
    usersSub?.cancel();
    usersSub = homeRepo.getOtherUsers(myId).listen(
        (usersList) => emit(CreateChatSucessState(userList: usersList)),
        onError: (error) => emit(CreateChatFailureState(errMessage: error.toString())));
  }

  // 2- create chat
  Future<void> createChat(String otherUserId)async{
    emit(CreateChatLoadingState());
    try {
  final chatId = await homeRepo.createChat(myId, otherUserId);
  emit(CreateChatCreated(chatId));
} catch (e) {
  emit(CreateChatFailureState(errMessage: e.toString()));
}
  }

   @override
  Future<void> close() {
    usersSub?.cancel();
    return super.close();
  }
}
