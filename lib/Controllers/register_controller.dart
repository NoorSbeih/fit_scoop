import 'package:firebase_auth/firebase_auth.dart';
import '../Services/Database Services/user_service.dart';
import '../Services/authentication_service.dart';
import '../Models/user_model.dart' as model;

class RegisterController {

  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();
  static late String userId;
  Future<void> storeRegisterData(String name, String email, String password) async {
    try {
      // Attempt to sign up the user with FirebaseAuth
      User? user = await _authService.signUpWithEmail(email, password);
      if (user != null) {
        userId = user.uid; // Get the newly created user ID// Get the newly created user ID

      // Prepare user data
      Map<String, dynamic> userData = {
        // 'id': userId, // Depending on your UserService implementation, you might not need to pass this
        'name': name,
        'email': email,
        'profilePictureUrl': '',
        'bodyMetrics': null,
        'followedUserIds': [],
        'savedWorkoutIds': [],
      };
      model.User usermodel = model.User(id: userId, name: name, email: email);

      await _userService.addUser(usermodel);
      print('Data saved successfully!');}
    } catch (error) {
      print('Error saving data: $error');
    }
  }

}