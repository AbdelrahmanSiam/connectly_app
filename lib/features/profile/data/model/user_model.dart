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

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.profilePictureUrl = "",
      this.bio = '',
      required this.isOnline,
      required this.createdAt,
      required this.lastSeen,});

  factory UserModel.fromJson(Map<String, dynamic> user) {
    return UserModel(
      id: user["id"] ?? "",
      name: user["name"] ?? "",
      email: user["email"] ?? "",
      profilePictureUrl: user["profilePictureUrl"] ?? "",
      bio: user["bio"] ?? "",
      isOnline: user["isOnline"] ?? false,
      createdAt: (user["createdAt"] as Timestamp).toDate(),
      lastSeen: (user["lastSeen"] as Timestamp).toDate(),
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
    };
  }
}
