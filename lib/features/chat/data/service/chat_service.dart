import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly/constants.dart';

class ChatService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<void> addMessage(Map<String, dynamic> message) async {
    await firebaseFirestore.collection(kMessagesCollection).add(message);
  }

  Stream<List<Map<String, dynamic>>> fetchChatMessages(
      {required String chatId}) {
    return firebaseFirestore
        .collection(kMessagesCollection)
        .where(kChatId, isEqualTo: chatId)
        .orderBy(kCreatedAt, descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}
