import 'package:connectly/constants.dart';

class MessageModel {
  final String messageId;
  final String message;
  final String senderId;
  final String receiverId;
  final DateTime createdAt;
  final String chatId;

  MessageModel( {
    required this.chatId,
    required this.messageId,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      chatId:json[kChatId],
      messageId: json[kMessageId],
      message: json[kMessage],
      senderId: json[kSenderId],
      receiverId: json[kReceiverId],
      createdAt: DateTime.parse(json[kCreatedAt]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      kChatId : chatId,
      kMessageId: messageId,
      kMessage: message,
      kSenderId: senderId,
      kReceiverId: receiverId,
      kCreatedAt: createdAt.toIso8601String(),
    };
  }
}
