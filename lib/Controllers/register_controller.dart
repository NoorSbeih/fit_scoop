import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/bodyMetricsSingleton.dart';
import '../Models/body_metrics_model.dart';
import '../Models/user_model.dart';
import '../Models/user_singleton.dart';
import '../Services/Database Services/user_service.dart';
import '../Services/authentication_service.dart';
import '../Models/user_model.dart' as model;
import 'body_metrics_controller.dart';

class RegisterController {
  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();
  static late String userId;

  Future<void> storeRegisterData(String name, String email, String password) async {
    try {
      User? user = await _authService.signUpWithEmail(email, password);
      if (user != null) {
        userId = user.uid; // Get the newly created user ID
        model.User_model usermodel = model.User_model(id: userId, name: name, email: email);

        await _userService.addUser(usermodel);
        print('Data saved successfully!');
      } else {
        throw 'User sign up failed'; // Throw an error if user is null
      }
    } catch (error) {

      throw 'Error saving data: $error'; // Throw the error to propagate it up
    }
  }
  Future<String?> getUserBodyMetric(String user_id) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      DocumentSnapshot snapshot = await users.doc(user_id).get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data == null) {
          print('No data available for user_id: $user_id');
          return null;
        }
        User_model user = User_model.fromMap(data);
        UserSingleton.getInstance().setUser(user);

        final String? bodyMetrics = data['bodyMetrics'];

        if (bodyMetrics == null) {
          print('No bodyMetrics available for user_id: $user_id');
          return null;
        }

        BodyMetricsController controller = BodyMetricsController();
        BodyMetrics? bodyMetricss = await controller.fetchBodyMetrics(bodyMetrics);

        if (bodyMetricss == null) {
          print('Failed to fetch bodyMetrics for user_id: $user_id');
          return null;
        }

        BodyMetricsSingleton.getInstance().setBodyMetrics(bodyMetricss);
        return bodyMetrics;

      } else {
        print('Document with ID $user_id does not exist');
        return null;
      }
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }
}
