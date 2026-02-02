import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String lastMessage;
  final String lastSenderId;
  final List<String> users;
  final DateTime lastMessageTime;

  ChatModel(
      {required this.chatId,
      required this.lastMessage,
      required this.lastSenderId,
      required this.users,
      required this.lastMessageTime});

// We will receive doc from firebase as Map<String , dynamic > we want it to convert it to model
  factory ChatModel.fromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String , dynamic>; // to fetch fields from doc (doc.data())
    return ChatModel(
        chatId: doc.id,
        lastMessage: data["lastMessage"] ?? "",
        lastSenderId: data["lastSenderId"],
        users: List<String>.from(data["users"]),
        lastMessageTime: (data["lastMessageTime"] as Timestamp).toDate());
  }
}
