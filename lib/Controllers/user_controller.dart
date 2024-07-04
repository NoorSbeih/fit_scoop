import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_scoop/Models/equipment.dart';
import 'package:fit_scoop/Models/workout_model.dart';
import 'package:flutter/material.dart';

import '../Models/user_model.dart';
import '../Services/Database Services/user_service.dart';


class UserController {
  final _userService = UserService();


  Future<User_model?> getUser(String id) async {
    try {
      return await _userService.getUser(id);
    } catch (e) {
      //print('Error getting workout: $e');
      throw e;
    }
  }

  Future<void> updateProfile(User_model user) async {
    try {
      // Update user profile in Firestore
      await _userService.updateUser(user);
    } catch (e) {
      //print('Error updating user profile: $e');
      throw e;
    }
  }

  Future<void> followUser(String currentUserId, String followUserId) async {
    try {
      // Follow user with UserService
      await _userService.followUser(currentUserId, followUserId);
    } catch (e) {
      //print('Error following user: $e');
      throw e;
    }
  }

  Future<void> unfollowUser(String currentUserId, String unfollowUserId) async {
    try {
      // Unfollow user with UserService
      await _userService.unfollowUser(currentUserId, unfollowUserId);
    } catch (e) {
      //print('Error unfollowing user: $e');
      throw e;
    }
  }


  Future<void> addFollowing(String currentUserId, String followUserId) async {
    try {
      // Follow user with UserService
      await _userService.addFollowing(currentUserId, followUserId);
    } catch (e) {
      print('Error following user: $e');
      throw e;
    }
  }

  Future<void> removeFollowing(String currentUserId, String unfollowUserId) async {
    try {
      // Unfollow user with UserService
      await _userService.removeFollowing(currentUserId, unfollowUserId);
    } catch (e) {
      print('Error unfollowing user: $e');
      throw e;
    }
  }

  Future<void> saveWorkout(String userId, String? workoutId) async {
    try {
      // Save workout to user's savedWorkoutIds
      await _userService.saveWorkout(userId, workoutId);
    } catch (e) {
      //print('Error saving workout: $e');
      throw e;
    }
  }

  Future<void> unsaveWorkout(String userId, String? workoutId) async {
    try {
      // Unsave workout from user's savedWorkoutIds
      await _userService.unsaveWorkout(userId, workoutId);
    } catch (e) {
      //print('Error unsaving workout: $e');
      throw e;
    }
  }

  Future<void> updateProfileImage(Uint8List image, String userId) async {
    try {
      String? imageUrl = await _userService.saveData(image, userId);
      if (imageUrl != null) {
        // Update user document with the image URL
        // Here you would typically call a method in your user repository or service to update the user document
        //print('Image uploaded successfully. Image URL: $imageUrl');
      } else {
        //print('Error uploading image');
      }
    } catch (e) {
      //print('Error updating profile image: $e');
    }
  }
  Future<List<Workout>> getSavedWorkouts(String userId) async { //from userservices
    try {
      // Get saved workout IDs from user document
      List<Workout> savedWorkouts = await _userService.getSavedWorkouts(userId);
      return savedWorkouts;
    } catch (e) {
      //print('Error getting saved workouts: $e');
      throw e;
    }
  }

  Future<List<User_model>> getAllUsers() async { //from userservices
    try {
      // Get saved workout IDs from user document
      List<User_model> savedWorkouts = await _userService.getAllUsers();
      return savedWorkouts;
    } catch (e) {
      //print('Error getting saved workouts: $e');
      throw e;
    }
  }


  Future<List<String>> getSavedEquipments(String userId) async { //from userservices
    try {
      // Get saved workout IDs from user document
      List<String> savedEquipments = await _userService.getSavedEquipments(userId);
      return savedEquipments;
    } catch (e) {
      //print('Error getting saved workouts: $e');
      throw e;
    }
  }


  Future<void> saveEquipments(String userId, List<String> equipmentsID) async {
    try {
      // Save workout to user's savedWorkoutIds
      await _userService.saveEquipments(userId, equipmentsID);
    } catch (e) {
      //print('Error saving workout: $e');
      throw e;
    }
  }




  Future<void> unsaveEquipments(String userId, List<String> equipmentsID) async {
    try {
      // Save workout to user's savedWorkoutIds
      await _userService.removeEquipments(userId, equipmentsID);
    } catch (e) {
      //print('Error saving workout: $e');
      throw e;
    }
  }


}