import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/features/chat/data/model/message_model.dart';

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


}
