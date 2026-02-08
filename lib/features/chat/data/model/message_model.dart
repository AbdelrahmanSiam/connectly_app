import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String text;
  final String senderId;
  final bool isSeen;
  final DateTime createdAt;
  final bool isEdited;
  final bool isDeleted;

  MessageModel({
    required this.messageId,
    required this.text,
    required this.senderId,
    required this.isSeen,
    required this.createdAt,
     this.isEdited = false,
     this.isDeleted = false,
  });

  factory MessageModel.fromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
        messageId: doc.id,
        text: data["text"],
        senderId: data["senderId"],
        isSeen: data["isSeen"] ?? false,
        createdAt: (data["createdAt"] as Timestamp).toDate(),
        isEdited: data["isEdited"] ?? false,
        isDeleted: data["isDeleted"] ?? false,
        );
  }

  Map<String, dynamic> toFirebase() {
    return {
      "text": text,
      "senderId": senderId,
      "isSeen": isSeen,
      "createdAt": Timestamp.fromDate(createdAt),
      "isEdited" : isEdited,
      "isDeleted" : isDeleted,
    };
  }
}
