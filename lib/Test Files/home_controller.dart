// home_controller.dart
import '../Services/authentication_service.dart';

class HomeController {
  final AuthenticationService _authService = AuthenticationService();

  Future<void> logout() async {
    await _authService.signOut();
  }
}