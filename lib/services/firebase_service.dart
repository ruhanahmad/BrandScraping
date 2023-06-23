import 'package:firebase_database/firebase_database.dart';
import 'package:scrapingdart/utils/helpers.dart';

import '../utils/static_data.dart';

class FirebaseService {
  void updateLastSeen() {
    // Get a reference to the Firebase Realtime Database
    DatabaseReference usersRef =
        FirebaseDatabase.instance.reference().child("users");
    // Set the timestamp value under the "1" key in the "users" node
    DateTime now = DateTime.now();
    int timestamp = now.millisecondsSinceEpoch;
    usersRef.child("${StaticData.loggedInUserId}").set(timestamp );
  }

  //jojo library missing hay woh sari add karo aor jo jo files hain woh copy karo 
  Future<DateTime> getUserLastSeen(userId) async {
    // Get a reference to the "users" node in the database
    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users/$userId");
    DataSnapshot snapshot =await usersRef.get();
    try {
      var epoch = int.parse(snapshot.value.toString());
      return epochToDateTime(epoch);
    }
    //hamesha jo hay na run without debugging kia karo
    // sun rai ho ?
    //yes pyar se kaho 

    // ha g g good girl
    //error na dalo 
    //nh dalti
    // be obedient 
    // jo hukm apka yaaar aise na bola karo kahin muje pyar na ho jay
    //khd to kaha pyr sy bolohaha han sai bat hay 
    //acha lagta hay jab respect milti hay
    catch(e)
    {
      //
    }
return DateTime(2021);

  }
}
