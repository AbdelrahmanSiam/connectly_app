import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId;
  final String lastMessage;
  final String lastSenderId;
  final List<String> users;
  final DateTime lastMessageTime;
  final DateTime createdAt;

  ChatModel({
    required this.chatId,
    required this.lastMessage,
    required this.lastSenderId,
    required this.users,
    required this.lastMessageTime,
    required this.createdAt,
  });

  factory ChatModel.fromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      chatId: doc.id,
      lastMessage: data["lastMessage"] ?? "",
      lastSenderId: data["lastSenderId"] ?? "",
      users: List<String>.from(data["users"]),
      lastMessageTime: (data["lastMessageTime"] as Timestamp).toDate(),
      createdAt: (data["createdAt"] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      "lastMessage": lastMessage,
      "lastSenderId": lastSenderId,
      "users": users,
      "lastMessageTime": Timestamp.fromDate(lastMessageTime),
      "createdAt": Timestamp.fromDate(createdAt),
    };
  }
}
