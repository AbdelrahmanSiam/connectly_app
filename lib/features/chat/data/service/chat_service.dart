import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:flutter/widgets.dart';

class ChatService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //1- fetch chat all messages
  Stream<QuerySnapshot> getChatMessages({required String chatId}) {
    return firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .orderBy("createdAt")
        .snapshots();
  }

  //2- send message
  Future<void> sendMessage(
      {required String chatId, required MessageModel messageModel}) async {
    final doc =
        firestore.collection("chats").doc(chatId).collection("messages").doc();
    await doc.set(messageModel.toFirebase());
    // update last message text and time and last sender id that appears on home view
    await firestore.collection("chats").doc(chatId).update({
      "lastMessage": messageModel.text,
      "lastMessageTime": Timestamp.fromDate(messageModel.createdAt),
      "lastSenderId": messageModel.senderId,
    });
  }

  Future<void> editMessage(
      {required String chatId,
      required String messageId,
      required String newText}) async {
    await firestore
        .collection("chats")
        .doc(chatId)
        .collection("messages")
        .doc(messageId)
        .update({"text": newText, "isEdited": true});
  }
}
