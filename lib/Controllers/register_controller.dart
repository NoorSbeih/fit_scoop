import 'package:firebase_auth/firebase_auth.dart';
import '../Services/Database Services/user_service.dart';
import '../Services/authentication_service.dart';

class RegisterController {
  final AuthenticationService _authService = AuthenticationService();
  final UserService _userService = UserService();

  Future<void> storeRegisterData(String name, String email, String password) async {
    try {
      // Attempt to sign up the user with FirebaseAuth
      UserCredential userCredential = (await _authService.signUpWithEmail(email, password)) as UserCredential;
      String userId = userCredential.user!.uid; // Get the newly created user ID

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


      await _userService.addUserDetails(userId, userData);
      print('Data saved successfully!');
    } catch (error) {
      print('Error saving data: $error');
    }
  }
}