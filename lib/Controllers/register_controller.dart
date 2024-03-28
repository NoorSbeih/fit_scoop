import 'package:firebase_database/firebase_database.dart';
import 'package:fit_scoop/Models/user_metrics_model.dart';
import 'package:fit_scoop/Models/user_model.dart';

import '../Services/authentication_service.dart';

class RegisterController {

  void storeRegisterData(String fullName, String email, String password) {
    try {
      User register = User(fullName, email);
      AuthenticationService auth= AuthenticationService();
      auth.signUpWithEmail(email, password);
      final databaseReference = FirebaseDatabase.instance.reference().child('Data');
      DatabaseReference newRef = databaseReference.push();
      newRef.set(register.toJson());
      User.key = newRef.key!;
      print("KEYYY"+User.key);
      /*final databaseReference = FirebaseDatabase.instance.reference().child('Data');
      databaseReference.push().set(register.toJson());*/
      print('Data saved successfully!');
    } catch (error) {
      print('Error saving data: $error');
    }
  }
  void storeBodyMetrics(String birthdate,String gender, String height,String weight ) {
    try {
      Body_Metrics body_metrics = Body_Metrics(birthdate,gender,height,weight);

      final databaseReference = FirebaseDatabase.instance.reference().child('Data');
      DatabaseReference newRef = databaseReference.child(User.key).child('Body Metrics');
      newRef.set(body_metrics.toJsonWithoutBodyFat());
      print('Data saved successfully!');
    } catch (error) {
      print('Error saving data: $error');
    }
  }
}