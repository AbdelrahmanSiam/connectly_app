import 'package:connectly/features/chat/data/models/message_model.dart';
import 'package:connectly/features/chat/data/repo/chat_repo.dart';
import 'package:connectly/features/chat/data/service/chat_service.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatService chatService;

  ChatRepoImpl({required this.chatService});
  @override
  Future<void> addMessage(MessageModel messageModel) async {
    await chatService.addMessage(messageModel.toJson());
  }

  @override
  Stream<List<MessageModel>> fetchChatMessages({required String chatId}) {
    return chatService.fetchChatMessages(chatId: chatId).map((messageMap) {
      return messageMap.map((message) {
        return MessageModel.fromJson(message);
      }).toList();
    });
  }
}
