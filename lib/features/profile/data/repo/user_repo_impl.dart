import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:connectly_app/features/profile/data/repo/user_repo.dart';
import 'package:connectly_app/features/profile/data/service/user_service.dart';

class UserRepoImpl implements UserRepo{
  final UserService userService;

  UserRepoImpl({required this.userService});
  @override
  Future<int> getChatsCount({required String userId}) async{
   return await userService.getChatsCount(userId);
  }

  @override
  Future<UserModel?> getUserModelById(String userId) async {
    return await userService.getUserModelById(userId:userId);
  }

}