import 'package:connectly_app/features/profile/data/model/user_model.dart';

abstract class UserRepo {
  Future<int> getChatsCount({required String userId});
  Future<UserModel> getUserModelById(String userId); 
}
