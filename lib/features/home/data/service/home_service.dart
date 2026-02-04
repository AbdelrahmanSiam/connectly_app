import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/features/home/data/model/chat_list_tile.dart';
import 'package:connectly_app/features/home/data/model/chat_model.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // 1- Fetch all chats for the login user from chats collection (Stream) ordering it depend on last chatting
  Stream<QuerySnapshot> getChats(String uid) {
    return firestore
        .collection("chats")
        .where("users", arrayContains: uid)
        .orderBy("lastMessageTime", descending: true)
        .snapshots();
  }

  // 2- We want ot get use other user id from users list on chat model

  // //2.1 first get other user id from users list
  // String getOtherUserId(ChatModel chatModel , String currentUserId){
  //   return chatModel.users.firstWhere((id) => id != currentUserId);
  // }
  // 2.2 get the UserModel
  Future<UserModel> getUserById(String userId) async {
    final doc =
        await firestore.collection("users").doc(userId).get(); // return all doc
    return UserModel.fromJson(doc.data()!);
  }

  //3- get all users from firebase
  Stream<QuerySnapshot> getOAllUsers() {
    return firestore.collection("users").snapshots();
  }

  // 4- create chat when click on list tile
  Future<String> createChat(String myId, String otherId) async {
    // - Check if thid chat existed or no
    try {
      final existingChat = await firestore
          .collection("chats")
          .where("users", arrayContains: myId)
          .get(); // return all chats that contains me
      for (final doc in existingChat.docs) {
        final users = List<String>.from(doc["users"]);
        if (users.contains(otherId)) {
          return doc.id; // return its id to open it and dont create new chat
        }
      }

      // 2- Create new Chat
      final doc = firestore.collection("chats").doc();
      final chatModel = ChatModel(
          chatId: doc.id,
          lastMessage: "",
          lastSenderId: "",
          users: [myId, otherId],
          lastMessageTime: DateTime.now(),
          createdAt: DateTime.now());

      doc.set(chatModel.toFirebase()); // add doc to chats coll
      return doc.id;
    } catch (e) {
      throw Exception("Failed to create chat");
    }
  }
}
