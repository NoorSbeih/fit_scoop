// models/exercise_model.dart

class Exercise {
  final String id;
  final String name;
  final String description;
  final String type;
  final List<String> muscleGroups;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.muscleGroups,
  });

  // Convert ExerciseModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'muscleGroups': muscleGroups,
    };
  }

  // Convert Firestore data to ExerciseModel
  factory Exercise.fromMap(String id, Map<String, dynamic> map) {
    return Exercise(
      id: id,
      name: map['name'],
      description: map['description'],
      type: map['type'],
      muscleGroups: List<String>.from(map['muscleGroups'] ?? []),
    );
  }
}

