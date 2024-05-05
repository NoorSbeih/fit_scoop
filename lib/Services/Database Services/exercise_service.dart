// services/database_services/exercise_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/exercise_model.dart';


class ExerciseService {
  final CollectionReference _exercisesRef = FirebaseFirestore.instance.collection('exercises');

  // Add new exercise document to Firestore
  Future<void> addExercise(Exercise exercise) async {
    try {
      await _exercisesRef.doc(exercise.id).set(exercise.toMap());
    } catch (e) {
      print('Error adding exercise: $e');
      throw e;
    }
  }

  // Update existing exercise document in Firestore
  Future<void> updateExercise(Exercise exercise) async {
    try {
      await _exercisesRef.doc(exercise.id).update(exercise.toMap());
    } catch (e) {
      print('Error updating exercise: $e');
      throw e;
    }
  }

  // Retrieve exercise document from Firestore based on exercise ID
  Future<Exercise?> getExercise(String id) async {
    try {
      var snapshot = await _exercisesRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        print("it is existttt");
        return Exercise.fromMap(id, snapshot.data() as Map<String, dynamic>);
      }
      return null; // Exercise not found
    } catch (e) {
      print('Error getting exercise: $e');
      throw e;
    }
  }

  // Delete exercise document from Firestore based on exercise ID
  Future<void> deleteExercise(String id) async {
    try {
      await _exercisesRef.doc(id).delete();
    } catch (e) {
      print('Error deleting exercise: $e');
      throw e;
    }
  }
}
