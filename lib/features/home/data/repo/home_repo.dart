import 'package:connectly_app/features/home/data/model/chat_model.dart';

abstract class HomeRepo {
  Stream<List<ChatModel>> getChats(String uid);
}