import 'package:connectly/features/home/data/models/user_model.dart';

abstract class HomeRepo {
  Stream<List<UserModel>> getAllUsers();
}
/*
Firestore
 → QuerySnapshot
   → List<QueryDocumentSnapshot>
     → Map<String, dynamic>
       → UserModel
         → Stream<List<UserModel>>

 */