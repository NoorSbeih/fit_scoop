
import 'package:fit_scoop/Models/user_model.dart';
class UserSingleton {
  static final UserSingleton _instance = UserSingleton._internal();
  late User_model _user;

  factory UserSingleton() {
    return _instance;
  }

  UserSingleton._internal();

  static UserSingleton getInstance() {
    return _instance;
  }

  void setUser(User_model user) {
    _user = user;
  }

  User_model getUser() {
    return _user;
  }
}
