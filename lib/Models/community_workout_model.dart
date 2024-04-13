import 'package:fit_scoop/Models/review_model.dart';
import 'package:fit_scoop/Models/workout_model.dart';

import 'exercise_model.dart';


class CommunityWorkout {
  final String id;
  final String name;
  final String description;
  final List<String> exercises;
  final int duration;
  final String intensity;
  final String creatorId;
  final int numberOfSaves;
  final List<String> reviews;

  CommunityWorkout({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.duration,
    required this.intensity,
    required this.creatorId,
    required this.numberOfSaves,
    required this.reviews,
  });

  // Convert CommunityWorkoutModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'exercises': exercises,
      'duration': duration,
      'intensity': intensity,
      'creatorId': creatorId,
      'numberOfSaves': numberOfSaves,
      'reviews': reviews,
    };
  }

  // Convert Firestore data to CommunityWorkoutModel
  factory CommunityWorkout.fromMap(String id, Map<String, dynamic> map) {
    return CommunityWorkout(
      id: id,
      name: map['name'],
      description: map['description'],
      exercises: List<String>.from(map['exercises'] ?? []),
      duration: map['duration'],
      intensity: map['intensity'],
      creatorId: map['creatorId'],
      numberOfSaves: map['numberOfSaves'],
      reviews: List<String>.from(map['reviews'] ?? []),
    );
  }
}
