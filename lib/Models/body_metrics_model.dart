class BodyMetrics {
  final double height;
  final double weight;
  final DateTime birthDate;
  final String gender;
  final String fitnessGoal;
  final String gymOrHome;


  BodyMetrics({
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.gender,
    required this.fitnessGoal,
    required this.gymOrHome,
  });

  Map<String, dynamic> toMap() {
    return {
      'height': height,
      'weight': weight,
      'birthDate': birthDate,
      'gender': gender,
      'fitnessGoal': fitnessGoal,
      'gymOrHome': gymOrHome,
    };
  }
}
