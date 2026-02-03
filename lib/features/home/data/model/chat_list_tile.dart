import 'package:connectly_app/features/home/data/model/chat_model.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';

class ChatListTileModel {
  final ChatModel chatModel;
  final UserModel userModel;

  ChatListTileModel({required this.chatModel, required this.userModel});
}
