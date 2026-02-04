import 'package:connectly_app/features/profile/data/model/user_model.dart';

class ChatArgumentsModel {
  final String chatId;
  final UserModel otherUser;

  ChatArgumentsModel({required this.chatId, required this.otherUser});
}