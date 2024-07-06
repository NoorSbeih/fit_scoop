// services/database_services/exercise_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/exercise_model.dart';


class ExerciseService {
  final CollectionReference _exercisesRef = FirebaseFirestore.instance.collection('exercises');

  // Add new exercise document to Firestore
  Future<void> addExercise(Exercise exercise) async {
    try {
      await _exercisesRef.doc(exercise.id).set(exercise.toMap());
    } catch (e) {
      //print('Error adding exercise: $e');
      throw e;
    }
  }

  // Update existing exercise document in Firestore
  Future<void> updateExercise(Exercise exercise) async {
    try {
      await _exercisesRef.doc(exercise.id).update(exercise.toMap());
    } catch (e) {
      //print('Error updating exercise: $e');
      throw e;
    }
  }

  // Retrieve exercise document from Firestore based on exercise ID
  Future<Exercise?> getExercise(String id) async {
    try {
      var snapshot = await _exercisesRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        //print("it is existttt");
        return Exercise.fromMap(id, snapshot.data() as Map<String, dynamic>);
      }
      return null; // Exercise not found
    } catch (e) {
      //print('Error getting exercise: $e');
      throw e;
    }
  }

  // method to get exercise name from id
  Future<String> getExerciseName(String id) async {
    try {
      Exercise? exercise = await getExercise(id);
      return exercise?.name ?? '';
    } catch (e) {
      //print('Error getting exercise name: $e');
      throw e;
    }
  }





  Future<List<Exercise>> getAllExercises() async {
    try {
      QuerySnapshot snapshot = await _exercisesRef.get();
      List<Exercise> exercises = snapshot.docs.map((doc) {
        return Exercise.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
      return exercises;
    } catch (e) {
      //print('Error getting exercises: $e');
      throw e;
    }
  }
  // Delete exercise document from Firestore based on exercise ID
  Future<void> deleteExercise(String id) async {
    try {
      await _exercisesRef.doc(id).delete();
    } catch (e) {
      //print('Error deleting exercise: $e');
      throw e;
    }
  }
  Future<List<Exercise>> getExercisesByMainMuscle(String mainMuscle,List<String> equipments) async {

      try {
        List<Exercise> exercises = [];

        // Fetch exercises based on the equipment
        for (String equipment in equipments) {
          QuerySnapshot equipmentSnapshot = await _exercisesRef
              .where('equipment', isEqualTo: equipment)
              .get();

          List<Exercise> equipmentExercises = equipmentSnapshot.docs
              .map((doc) => Exercise.fromMap(doc.id, doc.data() as Map<String, dynamic>))
              .toList();

          exercises.addAll(equipmentExercises);
        }

        // Remove duplicates by converting to a set and back to a list
        exercises = exercises.toSet().toList();

        // Filter exercises based on the main muscle
        List<Exercise> filteredExercises = exercises.where((exercise) =>
        exercise.bodyPart == mainMuscle
        ).toList();

        print('Found ${filteredExercises.length} exercises based on equipment and muscle');

        return filteredExercises;
      } catch (e) {

        print('Error getting exercises by available equipments and muscle: $e');
        throw Exception('Error getting exercises by available equipments and muscle: $e');
      }
    }

    Future<List<Exercise>> getExercisesByAvailableEquipments(List<String> equipments) async {
    try {
      equipments.add("body weight");
      List<Exercise> exercises=[];
      for (String equipment in equipments) {
        QuerySnapshot querySnapshot = await _exercisesRef
            .where('equipment', isEqualTo: equipment)
            .get();
        List<Exercise> ex = querySnapshot.docs
            .map((doc) =>
            Exercise.fromMap(doc.id, doc.data() as Map<String, dynamic>))
            .toList();
         exercises.addAll(ex);

      }
      print(exercises);
      return exercises;
    } catch (e) {
      //print('Error getting exercises by available equipments: $e');
      throw Exception('Error getting exercises by available equipments: $e');
    }
  }

}
