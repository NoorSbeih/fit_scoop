import 'exercise_model.dart';

// models/workout_model.dart

class Workout {
  final String id;
  final String name;
  final String description;
  final List<Map<String,dynamic>> exercises;
  final int duration;
  final String intensity;
  final String creatorId;

  Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.duration,
    required this.intensity,
    required this.creatorId,
  });

  // Convert WorkoutModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'exercises': exercises.map((exercise) => {
        'id': exercise['id'],
        'sets': exercise['sets'],
        'weight': exercise['weight'],
      }).toList(),
      'duration': duration,
      'intensity': intensity,
      'creatorId': creatorId,
    };
  }

  // Convert Firestore data to WorkoutModel
  factory Workout.fromMap(String id, Map<String, dynamic> map) {
    return Workout(
      id: id,
      name: map['name'],
      description: map['description'],
      exercises: List<Map<String,dynamic>>.from(map['exercises'] ?? []),
      duration: map['duration'],
      intensity: map['intensity'],
      creatorId: map['creatorId'],
    );
  }
}
