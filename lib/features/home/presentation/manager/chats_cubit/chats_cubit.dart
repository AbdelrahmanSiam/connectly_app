import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/home/data/model/chat_list_tile.dart';
import 'package:connectly_app/features/home/data/repo/home_repo.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.homeRepo) : super(ChatsInitialState());

  final HomeRepo homeRepo;
  String get currentUserId =>
    FirebaseAuth.instance.currentUser!.uid;

  List<ChatListTileModel> allChats = [];
  StreamSubscription? _chatsSub;
  

  void loadChats(){
    emit(ChatsLoadingState());
    _chatsSub?.cancel();
    _chatsSub= homeRepo.getChats(currentUserId).listen((allChatsList)async{
      final List <ChatListTileModel> chatsListTile = []; // we add this model that contains two models , because screen need data from these two different models 
      for(final chat in allChatsList){
        final otherUserId = chat.users.firstWhere((id) => id != currentUserId); // get uid of the other person who chat me from list users in chat model
        final otherUserModel = await homeRepo.getUserById(otherUserId); // get UserModel of other user id to show his photo , name , online state
        chatsListTile.add(ChatListTileModel(chatModel: chat, userModel: otherUserModel));
      }
      allChats = chatsListTile;
      emit(ChatsSuccessState(chats: allChats ));
    },
    onError: (error) {
      emit(ChatsFailureState(errMessage: error.toString()));},
    );
  }

  void searchChat ({required String query}){
    // if no query return all chats
    if(query.isEmpty){
      emit(ChatsSuccessState(chats: allChats));
      return;
    }
    // search by name or last message
    final filterdChats = allChats.where((ChatListTileModel chatTile){
      final name = chatTile.userModel.name.toLowerCase();
      final lastMessage = chatTile.chatModel.lastMessage.toLowerCase();
      final q = query.toLowerCase();
      return name.contains(q) || lastMessage.contains(q);
    }).toList();
    emit(ChatsSuccessState(chats: filterdChats));
  }

  @override
  Future<void> close() {
    _chatsSub?.cancel();
    return super.close();
  }
}
