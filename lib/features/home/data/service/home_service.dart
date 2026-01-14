import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectly/constants.dart';

class HomeService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  HomeService(this.firestore);

  // fetch all users from firebase (this what home view do)
  Stream<List<Map<String, dynamic>>> fetchAllUsers() {
    return firestore
        .collection(kUsersCollection)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    });
  }
}

/* 
firestore => collection => snapshot =map> docs =map> data as List< Map<String , dynamic>>

I have a FirebaseFirestore instance that connects me to Firebase.
1/ Through this instance, I access the users collection.
2/ From the collection, I listen to a real-time snapshots() stream which emits a QuerySnapshot.
3/ To transform this stream into usable data, I use .map() on the stream to receive the QuerySnapshot.
4/ Inside it, I access querySnapshot.docs, which contains a list of DocumentSnapshot.
5/ Since each DocumentSnapshot represents a single user, I apply another .map() to convert each document into raw data using doc.data() and cast it to Map<String, dynamic>.
6/ Finally, I convert the result into a List<Map<String, dynamic>>, which is the required output for the Home feature.

FirebaseFirestore instance
        ↓
users collection
        ↓
snapshots()  → Stream<QuerySnapshot>
        ↓
.map(QuerySnapshot)
        ↓
docs → List<DocumentSnapshot>
        ↓
.map(DocumentSnapshot)
        ↓
doc.data() as Map<String, dynamic>
        ↓
List<Map<String, dynamic>>
        ↓
Stream<List<Map<String, dynamic>>>

*/