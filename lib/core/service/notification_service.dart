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
    final settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    
    print('📱 Permission status: ${settings.authorizationStatus}');
  }

  Future<String?> getFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('📱 FCM Token: $token'); // ✅ Debug
    return token;
  }

  Future<void> saveToken(String userId) async {
    final token = await FirebaseMessaging.instance.getToken();
    
    if (token == null) {
      print('❌ No FCM token available');
      return;
    }
    
    print('✅ Saving token for user $userId: $token'); // ✅ Debug
    
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'fcmToken': token,
    });
    
    print('✅ Token saved successfully');
  }

  void listenToTokenRefresh(String userId) {
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      print('🔄 Token refreshed: $newToken');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'fcmToken': newToken});
    });
  }

  void listenToForegroundMessages() {
    if (_isListening) {
      print('⚠️ Already listening to foreground messages');
      return;
    }
    
    _isListening = true;
    print('👂 Started listening to foreground messages');
    
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📨 Foreground message received!');
      print('   Title: ${message.notification?.title}');
      print('   Body: ${message.notification?.body}');
      print('   Data: ${message.data}');
      
      if (message.notification == null) {
        print('❌ No notification in message');
        return;
      }

      final title = message.notification!.title ?? "New message";
      final body = message.notification!.body ?? "";

      NotificationSnackbar.show(title: title, message: body);
    });
  }
}