import 'package:connectly_app/features/home/data/model/chat_model.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';

abstract class HomeRepo {
  Stream<List<ChatModel>> getChats(String uid);
  Future<UserModel> getUserById(String userId); // to use it in showing list tile data
}