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
        userId = user.uid; // Get the newly created user ID

        // Prepare user data
        model.User usermodel = model.User(id: userId, name: name, email: email);

        await _userService.addUser(usermodel);
        print('Data saved successfully!');
      } else {
        throw 'User sign up failed'; // Throw an error if user is null
      }
    } catch (error) {

      throw 'Error saving data: $error'; // Throw the error to propagate it up
    }
  }
}
