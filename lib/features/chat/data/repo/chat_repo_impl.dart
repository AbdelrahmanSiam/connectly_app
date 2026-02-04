import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:connectly_app/features/chat/data/repo/chat_repo.dart';
import 'package:connectly_app/features/chat/data/service/chat_service.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatService chatService;

  ChatRepoImpl({required this.chatService});
  @override
  Stream<List<MessageModel>> getChatMessages({required String chatId}) {
    return chatService.getChatMessages(chatId: chatId).map((snapshot) =>
        snapshot.docs.map((doc) => MessageModel.fromFirebase(doc)).toList());
  }

  @override
  Future<void> sendMessage(
      {required String chatId, required MessageModel messageModel}) async{
    await chatService.sendMessage(chatId: chatId, messageModel: messageModel);
  }
}
