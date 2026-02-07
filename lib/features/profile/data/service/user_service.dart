import 'package:cloud_firestore/cloud_firestore.dart';

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
  }