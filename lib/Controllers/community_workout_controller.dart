
import '../Models/community_workout_model.dart';
import '../Services/Database Services/community_workout_service.dart';

class CommunityWorkoutController {
  final CommunityWorkoutService _communityWorkoutService = CommunityWorkoutService();

  Future<void> saveCommunityWorkout(CommunityWorkout communityWorkout) async {
    try {
      // Save community workout to the database using the CommunityWorkoutService
      await _communityWorkoutService.saveCommunityWorkout(communityWorkout);
    } catch (e) {
      print('Error saving community workout: $e');
      throw e;
    }
  }

  Future<void> unsaveCommunityWorkout(String id) async {
    try {
      // Unsave community workout from the database using the CommunityWorkoutService
      await _communityWorkoutService.unsaveCommunityWorkout(id);
    } catch (e) {
      print('Error unsaving community workout: $e');
      throw e;
    }
  }

  Future<List<CommunityWorkout>> fetchSavedCommunityWorkouts(String userId) async {
    try {
      // Fetch saved community workouts for a specific user from the database using the CommunityWorkoutService
      return await _communityWorkoutService.fetchSavedCommunityWorkouts(userId);
    } catch (e) {
      print('Error fetching saved community workouts: $e');
      throw e;
    }
  }

  Future<List<CommunityWorkout>> fetchCommunityWorkouts() async {
    try {
      // Fetch all community workouts from the database using the CommunityWorkoutService
      return await _communityWorkoutService.fetchCommunityWorkouts();
    } catch (e) {
      print('Error fetching community workouts: $e');
      throw e;
    }
  }

// Add more methods as needed
}
