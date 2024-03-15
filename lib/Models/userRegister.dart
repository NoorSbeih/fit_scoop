
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_scoop/Classes/Register.dart';

class userRegister {
  void storeRegisterData(String fullName, String email, String password, UnitMeasure unitMeasure) {
    try {
      Register register = Register(fullName, email, password, unitMeasure);
      final databaseReference = FirebaseDatabase.instance.reference().child('Data');
      databaseReference.push().set(register.toJson());
      print(unitMeasure);
      print('Data saved successfully!');
    } catch (error) {
      print('Error saving data: $error');
    }
  }
}

