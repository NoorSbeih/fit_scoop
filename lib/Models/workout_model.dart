import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../Controllers/workout_controller.dart';
import 'exercise_model.dart';

// models/workout_model.dart

class Workout {
  String? id;
  final String name;
  final String description;
  final List<Map<String,dynamic>> exercises;
  final int duration;
  final String intensity;
  final String creatorId;
   int numberOfSaves;
  final List<String> reviews;
  final bool isPrivate;
  final DateTime timestamp;



  Workout({
    this.id,
    required this.name,
    required this.description,
    required this.exercises,
    required this.duration,
    required this.intensity,
    required this.creatorId,
    required this.numberOfSaves,
    required this.reviews,
    required this.isPrivate,
    required this.timestamp
  });


  Future<void> updateNumberOfSaves(int newNumberOfSaves) async {
    try {
      WorkoutController workoutController = WorkoutController();

      // Create a new instance of Workout with the updated numberOfSaves
      Workout updatedWorkout = Workout(
        id: id,
        name: name,
        description: description,
        exercises: exercises,
        duration: duration,
        intensity: intensity,
        creatorId: creatorId,
        numberOfSaves: newNumberOfSaves,
        reviews: reviews,
        isPrivate: isPrivate,
        timestamp: DateTime.timestamp(),
      );

      await workoutController.updateWorkout(updatedWorkout);

      //print(updatedWorkout.numberOfSaves);
    } catch (e) {
      //print('Error updating numberOfSaves: $e');
      throw e;
    }
  }

  // Convert WorkoutModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'exercises': exercises.map((exercise) => {
        'id': exercise['id'],
        'name':exercise['name'],
        'sets': exercise['sets'],
        'weight': exercise['weight'],
      }).toList(),
      'duration': duration,
      'intensity': intensity,
      'creatorId': creatorId,
      'numberOfSaves': numberOfSaves,
      'isPrivate': isPrivate,
      'timestamp': timestamp,

    };
  }

  // Convert Firestore data to WorkoutModel
  factory Workout.fromMap(String id, Map<String, dynamic> map) {
    return Workout(
      id: id,
      name: map['name'],
      description: map['description'],
      exercises: parseExercises(map['exercises']),
      duration: map['duration'],
      intensity: map['intensity'],
      creatorId: map['creatorId'],
      numberOfSaves: map['numberOfSaves'],
      reviews: List<String>.from(map['reviews'] ?? []),
      isPrivate: map['isPrivate'],
      timestamp:  map['timestamp'] is String
          ? DateTime.parse(map['timestamp'])
          : (map['timestamp'] as Timestamp).toDate(),
    );
  }

}
List<Map<String, dynamic>> parseExercises(dynamic exercises) {
  List<Map<String, dynamic>> parsedExercises = [];

  if (exercises is List<dynamic>) {
    // If exercises is already a list, return it directly
    return List<Map<String, dynamic>>.from(exercises);
  } else if (exercises is String) {
    // If exercises is a string, parse it as JSON
    try {
      List<dynamic> parsedList = jsonDecode(exercises);
      if (parsedList is List<dynamic>) {
        // Check if the parsed result is indeed a list
        for (var item in parsedList) {
          if (item is Map<String, dynamic>) {
            parsedExercises.add(item);
          } else {
            //print('Invalid exercise format: $item');
          }
        }
      }
    } catch (e) {
      //print('Error parsing exercises: $e');
    }
  }

  return parsedExercises;
}