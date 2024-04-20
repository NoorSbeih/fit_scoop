import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/community_workout_model.dart';


class CommunityWorkoutService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'community_workouts';

  Future<void> saveCommunityWorkout(CommunityWorkout communityWorkout) async {
    try {
      await _firestore.collection(_collectionName).doc(communityWorkout.id).set(communityWorkout.toMap());
    } catch (e) {
      print('Error saving community workout: $e');
      throw e;
    }
  }

  Future<void> unsaveCommunityWorkout(String id) async {
    try {
      await _firestore.collection(_collectionName).doc(id).delete();
    } catch (e) {
      print('Error unsaving community workout: $e');
      throw e;
    }
  }

  Future<List<CommunityWorkout>> fetchSavedCommunityWorkouts(String userId) async {
    try {
      final querySnapshot = await _firestore.collection(_collectionName).where('userId', isEqualTo: userId).get();
      return querySnapshot.docs.map((doc) => CommunityWorkout.fromMap(doc.id, doc.data())).toList();
    } catch (e) {
      print('Error fetching saved community workouts: $e');
      throw e;
    }
  }

  Future<List<CommunityWorkout>> fetchCommunityWorkouts() async {
    try {
      final querySnapshot = await _firestore.collection(_collectionName).get();
      return querySnapshot.docs.map((doc) => CommunityWorkout.fromMap(doc.id, doc.data())).toList();
    } catch (e) {
      print('Error fetching community workouts: $e');
      throw e;
    }
  }

// Add more methods as needed
}
