import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly_app/core/widgets/notification_snackbar%20.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool _isListening = false;

  
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

  void listenToTokenRefresh(String userId) {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'fcmToken': newToken});
    });
  }

  void listenToForegroundMessages() {
    if (_isListening) return;
    _isListening = true;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification == null) return;

      final title = message.notification!.title ?? "New message";
      final body = message.notification!.body ?? "";

      // Use navigatorKey to show snackbar globally
      NotificationSnackbar.show(title: title, message: body);
    });
  }
}
