import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/core/utils/service_locator.dart';
import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:connectly_app/features/chat/data/repo/chat_repo.dart';
import 'package:connectly_app/features/profile/presentation/manager/user_cubit/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitialState());
  final ChatRepo chatRepo;
  final String myId = FirebaseAuth.instance.currentUser!.uid;

  void loadMessages(String chatId) {
    emit(ChatLoadingState());
    chatRepo.getChatMessages(chatId: chatId).listen((messageList) {
      emit(ChatSuccesState(messageList: messageList));
    }, onError: (error) {
      emit(ChatFailureState(errMessage: error.toString()));
    });
  }
  // only text need to receive it from user
  Future<void> sendMessage(String chatId, String text, String senderName ,String receiverId,) async {
    if (text.trim().isEmpty) return;
    final messageModel = MessageModel(
        messageId: "",
        text: text,
        senderId: myId,
        isSeen: false,
        createdAt: DateTime.now(),
        senderName: senderName,
        receiverId: receiverId);
    await chatRepo.sendMessage(chatId: chatId, messageModel: messageModel);
  }

  Future<void> editMessage(String chatId , String messageId , String newText)async{
    await chatRepo.editMessage(chatId: chatId, messageId: messageId, newText: newText);
  }

  Future<void> deleteMessage(String chatId , String messageId )async{
    await chatRepo.deleteMessage(chatId: chatId, messageId: messageId);
  }
}
