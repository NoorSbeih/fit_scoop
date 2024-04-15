import 'package:firebase_database/firebase_database.dart';

class UserDataService {
  Future<void> getUserData(String email) async {
    final ref = FirebaseDatabase.instance.ref('Data');
    final snapshot = await ref.orderByChild('email').equalTo(email).once();

    if (snapshot != null) {
   
      DataSnapshot dataSnapshot = snapshot.snapshot;
      print(dataSnapshot.value);
    } else {
      print('No data available.');
    }
  }
}
