import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';

class UserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> getChatsCount(String userId) async {
    try {
            final querySnapshot = await firestore
          .collection('chats')
          .where('users', arrayContains: userId)
          .get();
      
      final count = querySnapshot.docs.length;
      
      return count;
      
    } catch (e) {
      throw Exception('Failed to get chats count');  
    }
  }

  Future<UserModel> getUserModelById(String userId) async {
    final doc =
        await firestore.collection("users").doc(userId).get(); // return all doc
    return UserModel.fromJson(doc.data()!);
  }
  }