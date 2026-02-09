import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String profilePictureUrl;
  final String bio;
  final bool isOnline;
  final DateTime createdAt;
  final DateTime lastSeen;
  final String? fcmToken;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl = "",
    this.bio = '',
    required this.isOnline,
    required this.createdAt,
    required this.lastSeen,
    this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(
      id: user["id"] ?? "",
      name: user["name"] ?? "Unknown",  // ✅ إضافة fallback
      email: user["email"] ?? "",
      profilePictureUrl: user["profilePictureUrl"]?.toString() ?? "",
      bio: user["bio"]?.toString() ?? "",
      isOnline: user["isOnline"] ?? false,
      createdAt: (user["createdAt"] as Timestamp?)?.toDate() ?? DateTime.now(),  // ✅ null check
      lastSeen: (user["lastSeen"] as Timestamp?)?.toDate() ?? DateTime.now(),  // ✅ null check
      fcmToken: user["fcmToken"]?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "profilePictureUrl": profilePictureUrl,
      "bio": bio,
      "isOnline": isOnline,
      "createdAt": Timestamp.fromDate(createdAt),
      "lastSeen": Timestamp.fromDate(lastSeen),
      "fcmToken": fcmToken,
    };
  }
}
