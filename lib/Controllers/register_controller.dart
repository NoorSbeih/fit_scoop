
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Services/authentication_service.dart';

class RegisterController {
  void storeRegisterData(String fullName, String email, String password) {
    try {
      User register = User(fullName, email);
      AuthenticationService auth= AuthenticationService();
      auth.signUpWithEmail(email, password);
      final databaseReference = FirebaseDatabase.instance.reference().child('Data');
      databaseReference.push().set(register.toJson());
      print('Data saved successfully!');
    } catch (error) {
      print('Error saving data: $error');
    }
  }
}

