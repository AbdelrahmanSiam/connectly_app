import 'package:connectly/constants.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? profilePicUrl;
  final bool onlineState;
  final String lastMessage;

  UserModel(
      {required this.uid,
      required this.name,
      required this.email,
      this.profilePicUrl,
      required this.onlineState,
      required this.lastMessage});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        uid: json[kUid],
        name: json[kName] ?? "",
        email: json[kEmail] ?? "",
        profilePicUrl: json[kProfilePicUrl],
        onlineState: json[kOnlineState] ?? false,
        lastMessage : json[kLastMessage] ?? "");
  }

  Map<String, dynamic> toJson() => {
        kUid: uid,
        kName: name,
        kEmail: email,
        kProfilePicUrl: profilePicUrl,
        kOnlineState: onlineState,
        kLastMessage : lastMessage,
      };
}
