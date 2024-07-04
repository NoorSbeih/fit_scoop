
import '../Models/workout_model.dart';
import '../Services/Database Services/workout_service.dart';



class WorkoutController {
  final _workoutService = WorkoutService();

  Future<void> createWorkout(Workout workout) async {
    try {
      // Add the workout to Firestore
      await _workoutService.createWorkout(workout);
    } catch (e) {
      //print('Error creating workout: $e');
      throw e;
    }
  }

  Future<void> updateWorkout(Workout workout) async {
    try {
      // Update the workout in Firestore
      await _workoutService.updateWorkout(workout);
    } catch (e) {
      //print('Error updating workout: $e');
      throw e;
    }
  }

  Future<void> deleteWorkout(String id) async {
    try {
      // Delete the workout from Firestore
      await _workoutService.deleteWorkout(id);
    } catch (e) {
      //print('Error deleting workout: $e');
      throw e;
    }
  }

  Future<Workout?> getWorkout(String? id) async {
    try {

      return await _workoutService.getWorkout(id);
    } catch (e) {
      //print('Error getting workout: $e');
      throw e;
    }
  }
  // Future<List<Map<String, dynamic>>> getAllWorkouts() async {
  //   try {
  //     // Get all workouts from Firestore
  //     return await _workoutService.getAllWorkouts();
  //   } catch (e) {
  //     //print('Error getting all workouts: $e');
  //     throw e;
  //   }
  // }

  Future<List<Workout>> getAllWorkouts() async {
    try {
      // Get all workouts from Firestore
      return await _workoutService.getAllWorkouts();
    } catch (e) {
      //print('Error getting all workouts: $e');
      throw e;
    }
  }
  Future<List<Workout>> getWorkoutsByUserId(String? userId) async {
    try {
      if (userId == null) {
        throw ArgumentError.notNull('userId');
      }

      List<Workout> workouts = await _workoutService.getWorkoutsByUserId(userId);
      if (workouts.isEmpty) {
        //print('No workouts found for user ID: $userId');
      }
      return workouts;
    } catch (e) {
      // Handle error
      //print('Error getting workouts by user ID: $e');
      throw e;
    }
  }


// Add more methods as needed
}
