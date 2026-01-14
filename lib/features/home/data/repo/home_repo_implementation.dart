import 'package:connectly/features/home/data/models/user_model.dart';
import 'package:connectly/features/home/data/repo/home_repo.dart';
import 'package:connectly/features/home/data/service/home_service.dart';

class HomeRepoImplementation implements HomeRepo {
  final HomeService homeService;

  HomeRepoImplementation({required this.homeService});
  @override
  Stream<List<UserModel>> getAllUsers() {
    return homeService.fetchAllUsers().map((userMaps) {
      return userMaps.map((userMap) {
        return UserModel.fromJson(userMap);
      }).toList();
    });
  }
}

/* 
          Stream<Map> → for → List<UserModel>   (wrong)

Stream<List<Map>>                (correct)
   ↓ map(event)
List<Map>
   ↓ map(item)
UserModel

The method in HomeService returns a Stream<List<Map<String, dynamic>>>.
Since the data is emitted asynchronously over time, we cannot use a normal for loop directly on the stream.
Instead, we use the .map() method on the stream itself to transform each emitted list of maps into a list of UserModel objects.
*/
