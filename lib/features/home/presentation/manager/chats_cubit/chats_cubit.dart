import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/home/data/model/chat_list_tile.dart';
import 'package:connectly_app/features/home/data/repo/home_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this.homeRepo) : super(ChatsInitialState());

  final HomeRepo homeRepo;
  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  void loadChats(){
    emit(ChatsLoadingState());
    homeRepo.getChats(currentUserId).listen((allChatsList)async{
      final List <ChatListTileModel> chatsListTile = []; // we add this model that contains two models , because screen need data from these two different models 
      for(final chat in allChatsList){
        final otherUserId = chat.users.firstWhere((id) => id != currentUserId); // get uid of the other person who chat me from list users in chat model
        final user = await homeRepo.getUserById(otherUserId); // get UserModel of other user id to show his photo , name , online state
        chatsListTile.add(ChatListTileModel(chatModel: chat, userModel: user));
      }
      emit(ChatsSuccessState(chats: chatsListTile));
    });
  }
}
