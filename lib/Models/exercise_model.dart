// models/exercise_model.dart

class Exercise {
  final String id;
  final String name;
  final List<String> instructions;
  final String bodyPart;
  final String target;
  final List<String> secondaryMuscles;
  final String gifUrl;
  final String equipment;

  Exercise({
    required this.id,
    required this.name,
    required this.instructions,
    required this.bodyPart,
    required this.target,
    required this.secondaryMuscles,
    required this.equipment,
    required this.gifUrl
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'instructions': instructions,
      'bodyPart': bodyPart,
      'target': target,
      'secondaryMuscles':secondaryMuscles,
      'equipment': equipment,
      'gifUrl': gifUrl
    };
  }

  factory Exercise.fromMap(String id, Map<String, dynamic> map) {
    return Exercise(
      id: id,
      name: map['name'],
      instructions: map['instructions'].cast<String>(),
      bodyPart: map['bodyPart'],
      target: map['target'],
      secondaryMuscles:map['secondaryMuscles'].cast<String>(),
      equipment: map['equipment'],
      gifUrl: map['gifUrl']
    );
  }

}
