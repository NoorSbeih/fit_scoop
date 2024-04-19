import '../Models/exercise_model.dart';
import '../Services/Database Services/exercise_service.dart';



class ExerciseController {
  final ExerciseService _exerciseService = ExerciseService();

  Future<void> addExercise(Exercise exercise) async {
    try {
      // Add the exercise to the database using the ExerciseService
      await _exerciseService.addExercise(exercise);
    } catch (e) {
      print('Error adding exercise: $e');
      throw e;
    }
  }

  Future<void> updateExercise(Exercise exercise) async {
    try {
      // Update the exercise in the database using the ExerciseService
      await _exerciseService.updateExercise(exercise);
    } catch (e) {
      print('Error updating exercise: $e');
      throw e;
    }
  }

  Future<void> deleteExercise(String id) async {
    try {
      // Delete the exercise from the database using the ExerciseService
      await _exerciseService.deleteExercise(id);
    } catch (e) {
      print('Error deleting exercise: $e');
      throw e;
    }
  }


// Add more methods as needed
}
