import 'package:firebase_database/firebase_database.dart';
import 'package:fit_scoop/Models/user_model.dart';

class RegisterController {
  void storeRegisterData(String fullName, String email, String password, UnitMeasure unitMeasure) {
    try {
      User register = User(fullName, email);
      final databaseReference = FirebaseDatabase.instance.reference().child('Data');
      databaseReference.push().set(register.toJson());
      print(unitMeasure);
      print('Data saved successfully!');
    } catch (error) {
      print('Error saving data: $error');
    }
  }
}