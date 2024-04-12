import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Models/user_model.dart' as model;

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance; // Firestore instance

  // Reference to the users collection
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUserDetails(String userId, Map<String, dynamic> userDetails) async {
    try {
      await _userCollection.doc(userId).set(userDetails);
      print('User details added successfully');
    } catch (e) {
      print('Error adding user details: $e');
    }
  }
  Future<void> updateUserProfile(model.User user) async {
    await _userCollection.doc(user.id).update(user.toMap());
  }
  Future<void> followUser(String currentUserId, String followUserId) async {
    // Add followUserId to the current user's followedUserIds array
    await _userCollection.doc(currentUserId).update({
      'followedUserIds': FieldValue.arrayUnion([followUserId]),
    });

    // Optionally, update the followed user's document to include the current user's ID in a followers array
  }

  Future<void> unfollowUser(String currentUserId, String unfollowUserId) async {
    // Remove unfollowUserId from the current user's followedUserIds array
    await _userCollection.doc(currentUserId).update({
      'followedUserIds': FieldValue.arrayRemove([unfollowUserId]),
    });

    // Optionally, update the unfollowed user's document to remove the current user's ID from a followers array
  }



}
