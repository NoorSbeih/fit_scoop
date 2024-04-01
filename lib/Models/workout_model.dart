import 'exercise_model.dart';

class Workout {
  final String id;
  final String name;
  final String? description;
  final List<Exercise> exercises;
  final int duration;
  final String? intensity;
  final String creatorId;

  Workout({
    required this.id,
    required this.name,
    this.description,
    required this.exercises,
    required this.duration,
    this.intensity,
    required this.creatorId,
  });
}
