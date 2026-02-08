import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<void> requestPermission() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<String?> getFcmToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  Future<void> saveToken(String userId) async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null) return;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'fcmToken': token,
    });
  }
}
