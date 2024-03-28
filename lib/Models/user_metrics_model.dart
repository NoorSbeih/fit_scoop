class Body_Metrics {

  late String birth_date;
  late String gender;
  late String height;
  late String weight;
  late int body_fat;
  Body_Metrics(
      this.birth_date, this.gender, this.height, this.weight);

  Map<String, dynamic> toJsonWithoutBodyFat() {
    return {
      'birthdate': birth_date,
      'gender': gender,
      'height': height,
      'weight': weight,
    };
  }
  Map<String, dynamic> toJsonWithBodyFat() {
    return {
      'birth_date': birth_date,
      'gender': gender,
      'height': height,
      'weight': weight,
      'body_fat': body_fat,
    };
  }


}