import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  final FirebaseFirestore firestore;

  HomeService({required this.firestore});

  // 1- Fetch all chats for the login user from chats collection (Stream) ordering it depend on last chatting
  Stream<QuerySnapshot> getChats(String uid) {
    return firestore
        .collection("chats")
        .where("users", arrayContains: uid)
        .orderBy("lastMessageTime", descending: true)
        .snapshots();
  }
}
