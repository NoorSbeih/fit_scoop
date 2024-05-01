
import 'package:fit_scoop/Models/workout_model.dart';

class BodyMetrics {
  final String userId; // User ID associated with these metrics
  final double height;
  final double weight;
  final DateTime birthDate;
  final String gender;
  final double bodyFat;
  final List<String> fitnessGoal;
  final String gymType;
  final List<List<String>> workoutSchedule; // List of workouts for each day

  BodyMetrics({
    required this.userId,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.gender,
    required this.bodyFat,
    required this.fitnessGoal,
    required this.gymType,
    List<List<String>>? workoutSchedule, // Optional parameter for workout schedule
  }) : this.workoutSchedule = workoutSchedule ?? List.generate(7, (_) => []);

  // Convert BodyMetricsModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'height': height,
      'weight': weight,
      'birthDate': birthDate,
      'gender': gender,
      'bodyFat': bodyFat,
      'fitnessGoal': fitnessGoal,
      'gymType': gymType,
      'workoutSchedule': workoutSchedule,
    };
  }

  factory BodyMetrics.fromMap(Map<String, dynamic> map) {
    return BodyMetrics(
      userId: map['userId'],
      height: map['height'],
      weight: map['weight'],
      birthDate: map['birthDate'],
      gender: map['gender'],
      bodyFat: map['bodyFat'],
      fitnessGoal: List<String>.from(map['fitnessGoal'] ?? []),
      gymType: map['gymType'],
      workoutSchedule: List<List<String>>.from(map['workoutSchedule'] ?? List.generate(7, (_) => [])),
    );
  }
}



