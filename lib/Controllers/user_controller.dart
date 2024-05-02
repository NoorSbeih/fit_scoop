import 'package:flutter/material.dart';

import '../Models/user_model.dart';
import '../Services/Database Services/user_service.dart';


class UserController {
  final _userService = UserService();

  Future<void> updateProfile(User_model user) async {
    try {
      // Update user profile in Firestore
      await _userService.updateUser(user);
    } catch (e) {
      print('Error updating user profile: $e');
      throw e;
    }
  }

  Future<void> followUser(String currentUserId, String followUserId) async {
    try {
      // Follow user with UserService
      await _userService.followUser(currentUserId, followUserId);
    } catch (e) {
      print('Error following user: $e');
      throw e;
    }
  }

  Future<void> unfollowUser(String currentUserId, String unfollowUserId) async {
    try {
      // Unfollow user with UserService
      await _userService.unfollowUser(currentUserId, unfollowUserId);
    } catch (e) {
      print('Error unfollowing user: $e');
      throw e;
    }
  }

  Future<void> saveWorkout(String userId, String workoutId) async {
    try {
      // Save workout to user's savedWorkoutIds
      await _userService.saveWorkout(userId, workoutId);
    } catch (e) {
      print('Error saving workout: $e');
      throw e;
    }
  }

  Future<void> unsaveWorkout(String userId, String workoutId) async {
    try {
      // Unsave workout from user's savedWorkoutIds
      await _userService.unsaveWorkout(userId, workoutId);
    } catch (e) {
      print('Error unsaving workout: $e');
      throw e;
    }
  }
}
