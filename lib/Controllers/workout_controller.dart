
import '../Models/workout_model.dart';
import '../Services/Database Services/workout_service.dart';



class WorkoutController {
  final _workoutService = WorkoutService();

  Future<void> createWorkout(Workout workout) async {
    try {
      // Add the workout to Firestore
      await _workoutService.addWorkout(workout);
    } catch (e) {
      print('Error creating workout: $e');
      throw e;
    }
  }

  Future<void> updateWorkout(Workout workout) async {
    try {
      // Update the workout in Firestore
      await _workoutService.updateWorkout(workout);
    } catch (e) {
      print('Error updating workout: $e');
      throw e;
    }
  }

  Future<void> deleteWorkout(String id) async {
    try {
      // Delete the workout from Firestore
      await _workoutService.deleteWorkout(id);
    } catch (e) {
      print('Error deleting workout: $e');
      throw e;
    }
  }

  Future<Workout?> getWorkout(String id) async {
    try {
      // Get the workout from Firestore
      return await _workoutService.getWorkout(id);
    } catch (e) {
      print('Error getting workout: $e');
      throw e;
    }
  }

// Add more methods as needed
}
