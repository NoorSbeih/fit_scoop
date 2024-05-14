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
  Future<Exercise?> getExercise(String id) async {
    try {
      return await _exerciseService.getExercise(id);
    } catch (e) {
      print('Error getting workout: $e');
      throw e;
    }
  }
  //method to get exercise name by id
  Future<String> getExerciseName(String id) async {
    try {
      return await _exerciseService.getExerciseName(id);
    } catch (e) {
      print('Error getting exercise name: $e');
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
  Future<List<Exercise>> getExercisesByStartingLetter(String letter) async {
    List<Exercise> allExercises = await _exerciseService.getAllExercises();
    return allExercises.where((exercise) => exercise.name.startsWith(letter)).toList();

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
  //a method to get all exercises by main muscle
  Future<List<Exercise>> getExercisesByMainMuscle(String mainMuscle) async {
    try {
      return await _exerciseService.getExercisesByMainMuscle(mainMuscle);
    } catch (e) {
      print('Error getting exercises by main muscle: $e');
      throw e;
    }
  }


// Add more methods as needed
}
