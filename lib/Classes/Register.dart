enum UnitMeasure { imperial, metric }

class Register {
 late String fullName;
 late String email;
 late String password;
 late UnitMeasure unitMeasure;

 Register(this.fullName, this.email, this.password, this.unitMeasure);

 Map<String, dynamic> toJson() {
  int unitMeasureValue = unitMeasure == UnitMeasure.imperial ? 1 : 2;
  return {
   'fullName': fullName,
   'email': email,
   'password': password,
   'unitMeasure':unitMeasureValue.toString(),
  };
 }
}

