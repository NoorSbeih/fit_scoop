import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Models/user_model.dart' as model;


class UserService {
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(model.User_model user) async {
    try {
      await _usersRef.doc(user.id).set(user.toMap());
    } catch (e) {
      print('Error adding user: $e');
      throw e;
    }
  }

  Future<void> updateUser(model.User_model user) async {
    try {
      await _usersRef.doc(user.id).update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
      throw e;
    }
  }

  Future<model.User_model?> getUser(String id) async {
    try {
      var snapshot = await _usersRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        return model.User_model.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error getting user: $e');
      throw e;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _usersRef.doc(id).delete();
    } catch (e) {
      print('Error deleting user: $e');
      throw e;
    }
  }

  Future<void> followUser(String currentUserId, String followUserId) async {
    try {
      await _usersRef.doc(currentUserId).update({
        'followedUserIds': FieldValue.arrayUnion([followUserId]),
      });
    } catch (e) {
      print('Error following user: $e');
      throw e;
    }
  }

  Future<void> unfollowUser(String currentUserId, String unfollowUserId) async {
    try {
      await _usersRef.doc(currentUserId).update({
        'followedUserIds': FieldValue.arrayRemove([unfollowUserId]),
      });
    } catch (e) {
      print('Error unfollowing user: $e');
      throw e;
    }
  }

  Future<void> saveWorkout(String userId, String workoutId) async {
    try {
      await _usersRef.doc(userId).update({
        'savedWorkoutIds': FieldValue.arrayUnion([workoutId]),
      });
    } catch (e) {
      print('Error saving workout: $e');
      throw e;
    }
  }

  Future<void> unsaveWorkout(String userId, String workoutId) async {
    try {
      await _usersRef.doc(userId).update({
        'savedWorkoutIds': FieldValue.arrayRemove([workoutId]),
      });
    } catch (e) {
      print('Error unsaving workout: $e');
      throw e;
    }
  }
}

