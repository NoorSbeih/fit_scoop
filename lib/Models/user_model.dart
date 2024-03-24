enum UnitMeasure { imperial, metric }

class User {
  late String userName;
  late String email;
  late String password;


  User(this.userName, this.email);

  get displayName => userName;

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,

    };
  }
}