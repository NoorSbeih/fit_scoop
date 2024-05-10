// models/exercise_model.dart

class Exercise {
  final String id;
  final String name;
  final String description;
  final String type;
  final String mainMuscle;
  final List<String> secondaryMuscleGroups;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.mainMuscle,
    required this.secondaryMuscleGroups,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'muscleGroups': secondaryMuscleGroups,
    };
  }

  factory Exercise.fromMap(String id, Map<String, dynamic> map) {
    return Exercise(
      id: id,
      name: map['name'],
      description: map['description'],
      type: map['type'],
      mainMuscle: map['mainMuscle'],
      secondaryMuscleGroups:map['muscleGroups'].cast<String>(),
    );
  }

}
