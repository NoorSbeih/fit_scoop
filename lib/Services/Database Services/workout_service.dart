// services/database_services/workout_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/workout_model.dart';


class WorkoutService {
  final CollectionReference _workoutsRef = FirebaseFirestore.instance.collection('workouts');

  // Add new workout document to Firestore
  Future<void> addWorkout(Workout workout) async {
    try {
      await _workoutsRef.doc(workout.id).set(workout.toMap());
    } catch (e) {
      print('Error adding workout: $e');
      throw e;
    }
  }

  // Update existing workout document in Firestore
  Future<void> updateWorkout(Workout workout) async {
    try {
      await _workoutsRef.doc(workout.id).update(workout.toMap());
    } catch (e) {
      print('Error updating workout: $e');
      throw e;
    }
  }

  // Retrieve workout document from Firestore based on workout ID
  Future<Workout?> getWorkout(String id) async {
    try {
      var snapshot = await _workoutsRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        return Workout.fromMap(id, snapshot.data() as Map<String, dynamic>);
      }
      return null; // Workout not found
    } catch (e) {
      print('Error getting workout: $e');
      throw e;
    }
  }

  // Delete workout document from Firestore based on workout ID
  Future<void> deleteWorkout(String id) async {
    try {
      await _workoutsRef.doc(id).delete();
    } catch (e) {
      print('Error deleting workout: $e');
      throw e;
    }
  }
}
