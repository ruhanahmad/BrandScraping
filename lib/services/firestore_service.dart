import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../utils/firebase.dart';
import '../utils/static_data.dart';

class FireStoreService {
  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> setUserLastSeen() async {
    Map<String, dynamic> lastSeen = {
      'last_seen': DateTime.now(),
    };

    try {
      await usersRef
          .doc(StaticData.loggedInUserId.toString())
          .update(lastSeen);
    } catch (e) {
      if (e is FirebaseException && e.code == 'not-found') {
        // Document doesn't exist, create a new one
        await usersRef
            .doc(StaticData.loggedInUserId.toString())
            .set(lastSeen);
      } else {
        // Rethrow the exception if it's not a "not-found" error
        rethrow;
      }
    }
  }

  Stream<DateTime> getLastSeenStream(String userId) {
    return usersRef
        .doc(userId)
        .snapshots()
        .map((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('last_seen')) {
          Timestamp timestamp = data['last_seen'];
          return timestamp.toDate();
        }
      }
      // Return null if the document or the field doesn't exist
      return DateTime.now();
    });
  }

  Future<DateTime> getLastSeen(String userId) async {
    DocumentSnapshot snapshot =
    await usersRef.doc(userId).get();
    if (snapshot.exists) {
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
      if (data != null && data.containsKey('last_seen')) {
        Timestamp timestamp = data['last_seen'];
        return timestamp.toDate();
      }
    }
    // Return null if the document or the field doesn't exist
    return DateTime(2021);
  }

}
