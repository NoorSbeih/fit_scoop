
class BodyMetrics {
  final String id; // User ID associated with these metrics
  final String height;
  final String  weight;
  final DateTime birthDate;
  final String gender;
  final List <String> fitnessGoal;
  final String gymOrHome;

  BodyMetrics({
    required this.id,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.gender,
    required this.fitnessGoal,
    required this.gymOrHome,
  });

  // Convert BodyMetricsModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'height': height,
      'weight': weight,
      'birthDate': birthDate,
      'gender': gender,
      'fitnessGoal': fitnessGoal,
      'gymOrHome': gymOrHome,
    };
  }

  // Convert Firestore data to BodyMetricsModel
  factory BodyMetrics.fromMap(Map<String, dynamic> map) {
    return BodyMetrics(
      height: map['height'],
      weight: map['weight'],
      birthDate: map['birthDate'],
      gender: map['gender'],
      fitnessGoal: map['fitnessGoal'],
      gymOrHome: map['gymOrHome'],
      id: map['id'],
    );
  }
}

