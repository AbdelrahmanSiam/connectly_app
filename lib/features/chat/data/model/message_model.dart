import 'package:cloud_firestore/cloud_firestore.dart';
class MessageModel {
  final String messageId;
  final String text;
  final String senderId;
  final bool isSeen;
  final DateTime createdAt;
  final bool isEdited;
  final bool isDeleted;
  final String senderName;
  final String receiverId;

  MessageModel({
    required this.messageId,
    required this.text,
    required this.senderId,
    required this.isSeen,
    required this.createdAt,
    this.isEdited = false,
    this.isDeleted = false,
    required this.senderName,
    required this.receiverId,
  });

  factory MessageModel.fromFirebase(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      messageId: doc.id,
      text: data["text"] ?? "",  // ✅ إضافة fallback
      senderId: data["senderId"] ?? "",
      isSeen: data["isSeen"] ?? false,
      createdAt: (data["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),  // ✅ إضافة null check
      isEdited: data["isEdited"] ?? false,
      isDeleted: data["isDeleted"] ?? false,
      senderName: data["senderName"] ?? "Unknown",  // ✅ إضافة fallback
      receiverId: data["receiverId"] ?? "",  // ✅ إضافة fallback
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      "text": text,
      "senderId": senderId,
      "isSeen": isSeen,
      "createdAt": Timestamp.fromDate(createdAt),
      "isEdited": isEdited,
      "isDeleted": isDeleted,
      "senderName": senderName,
      "receiverId": receiverId,
    };
  }
}