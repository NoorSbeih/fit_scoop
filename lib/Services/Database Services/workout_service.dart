// services/database_services/workout_service.dart


import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/workout_model.dart';


class WorkoutService {
  final CollectionReference _workoutsRef = FirebaseFirestore.instance.collection('workouts');

  Future<void> createWorkout(Workout workout) async {
    try {
      // Step 1: Create a new document reference with an auto-generated ID
      DocumentReference docRef = _workoutsRef.doc();
      String newId = docRef.id;
      workout.id = newId;

      // Step 4: Set the workout data to the document with the correct ID
      await docRef.set(workout.toMap());

      print('Workout added with ID: $newId');
    } catch (e) {
      print('Error creating workout: $e');
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

  // Future<List<Map<String, dynamic>>> getAllWorkouts() async {
  //   try {
  //     var querySnapshot = await _workoutsRef.get();
  //     return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  //   } catch (e) {
  //     print('Error getting all workouts: $e');
  //     throw e;
  //   }
  // }

  Future<List<Workout>> getAllWorkouts() async {
    try {
      var querySnapshot = await _workoutsRef.get();
      return querySnapshot.docs
          .map((doc) => Workout.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting all workouts: $e');
      throw e;
    }
  }
  Future<List<Workout>> getWorkoutsByUserId(String userId) async {
    try {
      var querySnapshot = await _workoutsRef.where('creatorId', isEqualTo: userId).get();
      return querySnapshot.docs
          .map((doc) => Workout.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting workouts by user ID: $e');
      throw e;
    }
  }

  Future<Workout?> getWorkout(String? id) async {
    try {

      var snapshot = await _workoutsRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        return Workout.fromMap(id!, snapshot.data() as Map<String, dynamic>);
      } else {
        print('Workout with ID $id does not exist or snapshot data is null.');

      }
    } catch (e, stackTrace) {
      print('Error getting workout: $e');
      print('Stack Trace: $stackTrace');
      throw e;
    }
    return null;
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
