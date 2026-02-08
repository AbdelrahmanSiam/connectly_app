import 'package:connectly_app/features/chat/data/model/message_model.dart';

abstract class ChatRepo {
  Stream<List<MessageModel>> getChatMessages({required String chatId});
  Future<void> sendMessage({required String chatId , required MessageModel messageModel});
  Future<void> editMessage({required String chatId , required String messageId , required String newText});
  Future<void> deleteMessage({required String chatId , required String messageId});
}