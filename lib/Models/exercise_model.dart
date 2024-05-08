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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type,
      'muscleGroups': muscleGroups,
    };
  }

  factory Exercise.fromMap(String id, Map<String, dynamic> map) {
    return Exercise(
      id: id,
      name: map['name'],
      description: map['description'],
      type: map['type'],
      muscleGroups:map['muscleGroups'].cast<String>(),
    );
  }

}
