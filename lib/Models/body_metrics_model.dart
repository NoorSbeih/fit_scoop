
class BodyMetrics {
 // final String id;
  final String user_id; // User ID associated with these metrics
  final double height;
  final double  weight;
  final DateTime birthDate;
  final String gender;
  final double bodyFat;
  final List <String> fitnessGoal;
  final String gymOrHome;

  BodyMetrics({
  //  required this.id,
    required this.user_id,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.gender,
    required this.bodyFat,
    required this.fitnessGoal,
    required this.gymOrHome,
  });

  // Convert BodyMetricsModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'user_id':user_id,
      'height': height,
      'weight': weight,
      'birthDate': birthDate,
      'gender': gender,
      'bodyFat':bodyFat,
      'fitnessGoal': fitnessGoal,
      'gymOrHome': gymOrHome,
    };
  }

  factory BodyMetrics.fromMap(Map<String, dynamic> map) {
    return BodyMetrics(
      height: map['height'],
      weight: map['weight'],
      birthDate: map['birthDate'],
      gender: map['gender'],
      bodyFat: map['bodyFat'],
      fitnessGoal: map['fitnessGoal'],
      gymOrHome: map['gymOrHome'],
   //   id: map['id'],
     user_id:map['user_id']
    );
  }
}

