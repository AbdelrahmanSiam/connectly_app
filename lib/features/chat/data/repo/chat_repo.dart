import 'package:connectly/features/chat/data/models/message_model.dart';

abstract class ChatRepo {
  Future<void> addMessage(MessageModel messageModel);
  Stream<List<MessageModel>> fetchAllChatMessages({required String chatId});
}
