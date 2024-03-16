enum UnitMeasure { imperial, metric }

class User {
 late String userName;
 late String email;


 User(this.userName, this.email);

 Map<String, dynamic> toJson() {
  return {
   'userName': userName,
   'email': email,

  };
 }
}

