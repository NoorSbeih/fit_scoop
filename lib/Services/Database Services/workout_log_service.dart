import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Models/workout_log.dart';

class WorkoutLogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'workoutLogs';

  // Add a new workout log
  Future<void> addWorkoutLog(WorkoutLog workoutLog) async {
    try {
      await _firestore.collection(_collection).doc(workoutLog.id).set(workoutLog.toMap());
    } catch (e) {
      throw Exception('Error adding workout log: $e');
    }
  }

  // Fetch a workout log by id
  Future<WorkoutLog?> getWorkoutLog(String? id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection(_collection).doc(id).get();
      if (doc.exists) {
        return WorkoutLog.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      throw Exception('Error fetching workout log: $e');
    }
    return null;
  }

  // Fetch all workout logs for a user
  Future<List<WorkoutLog>> getWorkoutLogsByUserId(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collection)
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) =>
          WorkoutLog.fromMap(doc.id, doc.data() as Map<String, dynamic>)
      ).toList();
    } catch (e) {
      throw Exception('Error fetching workout logs: $e');
    }
  }
  Future<WorkoutLog?> getWorkoutLogByWorkoutId(String? workoutId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collection)
          .where('workoutId', isEqualTo: workoutId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        return WorkoutLog.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching workout log: $e');
    }
  }


  // Update an existing workout log
  Future<void> updateWorkoutLog(WorkoutLog workoutLog) async {
    try {
      await _firestore.collection(_collection).doc(workoutLog.id).update(workoutLog.toMap());
    } catch (e) {
      throw Exception('Error updating workout log: $e');
    }
  }

  // Delete a workout log
  Future<void> deleteWorkoutLog(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting workout log: $e');
    }
  }
  Future<WorkoutLog?> getLatestWorkoutLogsByUserIdAndWorkoutId(String userId, String? workoutId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(_collection)
          .where('userId', isEqualTo: userId)
          .where('workoutId', isEqualTo: workoutId)
          .orderBy('timeTaken', descending: true)
          .limit(1)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        return WorkoutLog.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching workout logs: $e');
    }
  }
}
