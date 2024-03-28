
class User {
  late String userName;
  late String email;
  late String password;
  static late String key;
  User(this.userName, this.email);

  get displayName => userName;

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,

    };
  }


  }


