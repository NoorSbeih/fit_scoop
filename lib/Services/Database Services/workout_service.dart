// services/database_services/workout_service.dart

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/workout_model.dart';

class WorkoutService {
  final CollectionReference _workoutsRef =
  FirebaseFirestore.instance.collection('workouts');

  Future<void> createWorkout(Workout workout) async {
    try {
      // Step 1: Create a new document reference with an auto-generated ID
      DocumentReference docRef = _workoutsRef.doc();
      String newId = docRef.id;
      workout.id = newId;

      // Step 4: Set the workout data to the document with the correct ID
      await docRef.set(workout.toMap());

      //print('Workout added with ID: $newId');
    } catch (e) {
      //print('Error creating workout: $e');
      throw e;
    }
  }

  // Update existing workout document in Firestore
  Future<void> updateWorkout(Workout workout) async {
    try {
      await _workoutsRef.doc(workout.id).update(workout.toMap());
    } catch (e) {
      //print('Error updating workout: $e');
      throw e;
    }
  }

  // Future<List<Map<String, dynamic>>> getAllWorkouts() async {
  //   try {
  //     var querySnapshot = await _workoutsRef.get();
  //     return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  //   } catch (e) {
  //     //print('Error getting all workouts: $e');
  //     throw e;
  //   }
  // }

  Future<List<Workout>> getAllWorkouts() async {
    try {
      var querySnapshot = await _workoutsRef.get();
      return querySnapshot.docs
          .map((doc) =>
          Workout.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      //print('Error getting all workouts: $e');
      throw e;
    }
  }

  Future<List<Workout>> getWorkoutsByUserId(String userId) async {
    try {
      var querySnapshot =
      await _workoutsRef.where('creatorId', isEqualTo: userId).get();
      return querySnapshot.docs
          .map((doc) =>
          Workout.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      //print('Error getting workouts by user ID: $e');
      throw e;
    }
  }

  Future<Workout?> getWorkout(String? id) async {
    try {
      var snapshot = await _workoutsRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        return Workout.fromMap(id!, snapshot.data() as Map<String, dynamic>);
      } else {
        //print('Workout with ID $id does not exist or snapshot data is null.');
      }
    } catch (e, stackTrace) {
      //print('Error getting workout: $e');
      //print('Stack Trace: $stackTrace');
      throw e;
    }
    return null;
  }

  // Delete workout document from Firestore based on workout ID
  Future<void> deleteWorkout(String id) async {
    try {
      await _workoutsRef.doc(id).delete();
    } catch (e) {
      //print('Error deleting workout: $e');
      throw e;
    }
  }


  Future<List<Map<String, dynamic>>> transformExercises(
      List<Map<String, dynamic>> exercises,
      List<String> userEquipmentList) async {
    List<Map<String, dynamic>> transformedExercises = [];

    // Iterate through each exercise in the provided list and fetch details or keep originals
    for (var exercise in exercises) {
      String exerciseId = exercise['id']; // Assuming 'id' is present in each exercise map
      var exerciseDetails = await fetchExerciseDetails(exerciseId);

      List<String> tempEquipment = userEquipmentList + ["body weight"] + ['weighted'];


      if (exerciseDetails != null) {
        // Check if fetched equipment is in user's equipment list
        if (tempEquipment.contains(exerciseDetails['equipment'])) {
          transformedExercises.add(
              exercise); // Keep original exercise if equipment matches
        } else {
          // Find a replacement exercise that matches user's equipment and same muscle target
          var replacementExercise = await findReplacementExercise(
              exerciseDetails, tempEquipment, exercise['sets'],
              exercise['weight'], exercise['imageUrl']);
          if (replacementExercise != null) {
            transformedExercises.add(
                replacementExercise); // Add replacement exercise if found
          } else {
            transformedExercises.add(
                exercise); // Otherwise, keep the original exercise
          }
        }
      } else {
        transformedExercises.add(
            exercise); // If exercise details not found, keep the original exercise
      }
    }

    return transformedExercises;
  }

  // Function to find exercise details (equipment and target) from Firestore based on exercise id
  Future<Map<String, dynamic>?> fetchExerciseDetails(String exerciseId) async {
    // Query Firestore to fetch exercise details
    DocumentSnapshot exerciseDoc = await FirebaseFirestore.instance
        .collection('exercises')
        .doc(exerciseId)
        .get();

    // Check if exercise document exists and contains necessary attributes
    if (exerciseDoc.exists) {
      var exerciseData = exerciseDoc.data() as Map<String, dynamic>;
      // Assuming 'equipment' and 'target' are attributes in Firestore document
      if (exerciseData['equipment'] != null && exerciseData['target'] != null) {
        return {
          'id': exerciseId,
          'equipment': exerciseData['equipment'],
          'target': exerciseData['target'],
          // Include other attributes as needed from Firestore document
        };
      }
    }

    // If exercise details not found or incomplete, return null
    return null;
  }

// Function to find a replacement exercise based on exercise details and user equipment list
  Future<Map<String, dynamic>?> findReplacementExercise(
      Map<String, dynamic> exerciseDetails, List<String> userEquipmentList,
      String sets, String weight, String imageUrl) async {
    String targetMuscle = exerciseDetails['target']; // Assuming 'target' is fetched from Firestore

    // Query Firestore to find exercises targeting the same muscle and compatible with user's equipment
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('exercises')
        .where('target', isEqualTo: targetMuscle)
        .where('equipment', whereIn: userEquipmentList)
        .get();

    // Process query results
    if (querySnapshot.docs.isNotEmpty) {
      // Convert QuerySnapshot to a List of DocumentSnapshots
      List<DocumentSnapshot> documents = querySnapshot.docs;

      // Select a random document index
      Random random = Random();
      int randomIndex = random.nextInt(documents.length);

      // Get the random exercise document
      var exerciseDoc = documents[randomIndex];
      var exerciseData = exerciseDoc.data() as Map<String,
          dynamic>; // Explicit cast to Map<String, dynamic>

      // Check if exerciseData and necessary properties are not null before accessing
      if (exerciseData['name'] != null && exerciseData['equipment'] != null &&
          exerciseData['target'] != null) {
        // Construct and return the replacement exercise map
        return {
          'id': exerciseDoc.id, // Assuming 'id' is the document ID in Firestore
          'name': exerciseData['name'],
          'sets': sets, // Use sets from original exercise details
          'weight': weight, // Use weight from original exercise details
          'imageUrl': imageUrl, // Use imageUrl from original exercise details
          // Add other attributes as needed
        };
      }
    }

    // If no suitable replacement exercise found, return the original exercise
    return {
      'id': exerciseDetails['id'],
      'name': exerciseDetails['name'],
      'sets': sets,
      'weight': weight,
      'imageUrl': imageUrl,
    };

  }
}
