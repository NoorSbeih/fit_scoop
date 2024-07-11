import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Models/equipment.dart';
import '../../Models/user_model.dart' as model;
import 'dart:typed_data';

import '../../Models/workout_model.dart';



class UserService {
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('users');
  final CollectionReference _workoutsRef = FirebaseFirestore.instance.collection('workouts');
  final CollectionReference _equipmentsRef = FirebaseFirestore.instance.collection('equipment');
  Future<void> addUser(model.User_model user) async {
    try {
      await _usersRef.doc(user.id).set(user.toMap());
    } catch (e) {
      //print('Error adding user: $e');
      throw e;
    }
  }

  Future<void> updateUser(model.User_model user) async {
    try {
      await _usersRef.doc(user.id).update(user.toMap());
    } catch (e) {
      //print('Error updating user: $e');
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
      //print('Error getting user: $e');
      throw e;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _usersRef.doc(id).delete();
    } catch (e) {
      //print('Error deleting user: $e');
      throw e;
    }
  }

  Future<void> followUser(String currentUserId, String followUserId) async {
    try {
      await _usersRef.doc(currentUserId).update({
        'followedUserIds': FieldValue.arrayUnion([followUserId]),
      });
    } catch (e) {
      //print('Error following user: $e');
      throw e;
    }
  }




  Future<void> addFollowing(String currentUserId, String followUserId) async {
    try {
      await _usersRef.doc(followUserId).update({
        'followersUserIds': FieldValue.arrayUnion([currentUserId]),
      });
    } catch (e) {
      print('Error following user: $e');
      throw e;
    }
  }

  Future<void> removeFollowing(String currentUserId, String followUserId) async {
    try {
      await _usersRef.doc(followUserId).update({
        'followersUserIds': FieldValue.arrayRemove([currentUserId]),
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
      //print('Error unfollowing user: $e');
      throw e;
    }
  }

  Future<void> saveWorkout(String userId, String? workoutId) async {
    try {
      await _usersRef.doc(userId).update({
        'savedWorkoutIds': FieldValue.arrayUnion([workoutId]),
      });
    } catch (e) {
      //print('Error saving workout: $e');
      throw e;
    }
  }

  Future<void> unsaveWorkout(String userId, String? workoutId) async {
    try {
      await _usersRef.doc(userId).update({
        'savedWorkoutIds': FieldValue.arrayRemove([workoutId]),
      });
    } catch (e) {
      //print('Error unsaving workout: $e');
      throw e;
    }
  }

  Future<String?> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      Reference ref = FirebaseStorage.instance.ref().child('profile_images').child(childName); // Use childName instead of file for the child name
      UploadTask uploadTask = ref.putData(file); // Use putData instead of putFile for uploading byte data
      TaskSnapshot taskSnapshot = await uploadTask;
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl; // Return the image URL
    } catch (e) {
      //print('Error uploading image: $e');
      return null; // Return null if there's an error
    }
  }


  Future<String?> saveData(Uint8List file, String userId) async {
    try {
      String? imageUrl = await uploadImageToStorage('profile_$userId', file); // Use a unique child name for each user, such as 'profile_$userId'
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'imageLink': imageUrl, // Update the 'imageLink' field with the image URL
      });
      return imageUrl; // Return the image URL
    } catch (e) {
      //print('Error saving image: $e');
      return null;
    }
  }

  Future<List<Workout>> getSavedWorkouts(String userId) async {
    try {
      // Retrieve the user's document
      DocumentSnapshot userDoc = await _usersRef.doc(userId).get();

      if (userDoc.exists) {
        // Extract saved workout IDs
        List<String> savedWorkoutIds = List<String>.from(userDoc['savedWorkoutIds']);

        // Fetch workouts using the saved workout IDs
        List<Workout> workouts = [];
        for (String workoutId in savedWorkoutIds) {
          DocumentSnapshot workoutDoc = await _workoutsRef.doc(workoutId).get();
          if (workoutDoc.exists) {
            workouts.add(Workout.fromMap(workoutDoc.id, workoutDoc.data() as Map<String, dynamic>));
          }
        }

        return workouts;
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception('Error fetching saved workouts: $e');
    }
  }

  Future<List<model.User_model>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _usersRef.get();
      List<model.User_model> users = querySnapshot.docs.map((doc) {
        return model.User_model.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      //print(users);
      return users;
    } catch (e) {
      //print('Error getting all users: $e');
      throw e;
    }
  }


  Future<List<String>> getSavedEquipments(String userId) async {
    try {
      DocumentSnapshot userDoc = await _usersRef.doc(userId).get();
      if (userDoc.exists) {
        List<String> savedEquipmentsIds = List<String>.from(userDoc['savedEquipmentIds']);

        return savedEquipmentsIds;
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception('Error fetching saved equipments: $e');
    }
  }
  Future<void> saveEquipments(String userId, List<String> equipmentIds) async {
    try {
      await _usersRef.doc(userId).update({
        'savedEquipmentIds': FieldValue.arrayUnion(equipmentIds),
      });
    } catch (e) {
      //print('Error saving exercises: $e');
      throw e;
    }
  }
  Future<void> removeEquipments(String userId, List<String> equipmentIdsToRemove) async {
    try {
      await _usersRef.doc(userId).update({
        'savedEquipmentIds': FieldValue.arrayRemove(equipmentIdsToRemove),
      });
      //print('Removing equipment IDs: $equipmentIdsToRemove');
    } catch (e) {
      //print('Error removing equipment: $e');
      throw e;
    }
  }

  Future<bool> emailExists(String email) async {
    try {
      var result = await _usersRef.where('email', isEqualTo: email).limit(1).get();
      return result.docs.isNotEmpty;
    } catch (e) {
      //print('Error checking if email exists: $e');
      throw e;
    }
  }

}

