
import '../Models/workout_log.dart';
import '../Services/Database Services/workout_log_service.dart';

class WorkoutLogController {
  final WorkoutLogService _workoutLogService = WorkoutLogService();

  Future<void> addWorkoutLog(WorkoutLog workoutLog) async {
    try {
      await _workoutLogService.addWorkoutLog(workoutLog);
    } catch (e) {
      //print('Error adding workout log: $e');
    }
  }

  Future<WorkoutLog?> getWorkoutLog(String? id) async {
    try {
      return await _workoutLogService.getWorkoutLog(id);
    } catch (e) {
      //print('Error fetching workout log: $e');
    }
    return null;
  }
  Future<WorkoutLog?>getWorkoutLogByWorkoutId(String? workoutId) async {
    try {
      return await _workoutLogService.getWorkoutLogByWorkoutId(workoutId);
    } catch (e) {
      //print('Error fetching workout log: $e');
    }
    return null;
  }

  Future<List<WorkoutLog>> getWorkoutLogsByUserId(String userId) async {
    try {
      return await _workoutLogService.getWorkoutLogsByUserId(userId);
    } catch (e) {
      //print('Error fetching workout logs: $e');
      return [];
    }
  }

  Future<void> updateWorkoutLog(WorkoutLog workoutLog) async {
    try {
      await _workoutLogService.updateWorkoutLog(workoutLog);
    } catch (e) {
      //print('Error updating workout log: $e');
    }
  }

  Future<void> deleteWorkoutLog(String id) async {
    try {
      await _workoutLogService.deleteWorkoutLog(id);
    } catch (e) {
      //print('Error deleting workout log: $e');
    }
  }
}
