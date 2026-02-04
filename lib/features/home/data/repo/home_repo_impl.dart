import 'package:connectly_app/features/home/data/model/chat_model.dart';
import 'package:connectly_app/features/home/data/repo/home_repo.dart';
import 'package:connectly_app/features/home/data/service/home_service.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeService homeService;

  HomeRepoImpl({required this.homeService});
  @override
  Stream<List<ChatModel>> getChats(String uid) {
    // we have an snapshot form firebase as Map<String , dynamic> we want to convert it to List<ChatModel>
    return homeService.getChats(uid).map((snapshot) =>
        snapshot.docs.map((doc) => ChatModel.fromFirebase(doc)).toList());
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    return await homeService.getUserById(userId);
  }

  @override
  Stream<List<UserModel>> getOtherUsers(String uid) async* { // *async is Genrator fun return Stream user yield instand of return
    final usersStream = homeService.getOAllUsers().map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromJson(doc.data() as Map<String , dynamic>)).toList());
    final chats = await getChats(uid).first; //.first => take only first value and stop

    final chattedIds = chats
    .expand((e) => e.users)
    .where((e) => e != uid)
    .toSet(); // .expand => expand list as array

    await for (final users in usersStream) {
    yield users
        .where((u) => u.id != uid && !chattedIds.contains(u.id)) // return all users except me and chatted users
        .toList();
    }
}
}