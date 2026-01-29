import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<int> getChatsCount(String userId) async {
    try {
            final querySnapshot = await firestore
          .collection('chats')
          .where('participants', arrayContains: userId)
          .get();
      
      final count = querySnapshot.docs.length;
      
      return count;
      
    } catch (e) {
      print('❌ UserService: Error getting chats count - $e');
      return 0;  
    }
  }
  }