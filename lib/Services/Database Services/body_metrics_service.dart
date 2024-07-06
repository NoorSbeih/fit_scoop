// services/database_services/body_metrics_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_scoop/Services/Database%20Services/workout_schedule_service.dart';
import 'package:fit_scoop/Views/Screens/Workout/current_workout_screen.dart';
import '../../Models/body_metrics_model.dart';
import '../../Models/user_model.dart';
import '../../Models/user_singleton.dart';

class BodyMetricsService {
  final CollectionReference _bodyMetricsRef = FirebaseFirestore.instance.collection('bodyMetrics');
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('users');
  Future<void> addBodyMetrics(BodyMetrics bodyMetrics) async {
    try {
      DocumentReference documentRef = await _bodyMetricsRef.add(bodyMetrics.toMap());
      String documentId = documentRef.id;
     await _usersRef.doc(bodyMetrics.userId).update({'bodyMetrics':documentId});
      DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(bodyMetrics.userId).get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      User_model user = User_model.fromMap(data!);
      UserSingleton.getInstance().setUser(user);
      //print("Makakakakaka");
      //print(user.bodyMetrics);

    } catch (e) {
      //print('Error adding body metrics: $e');
      throw e;
    }
  }
  Future<void> updateWorkoutSchedule(String userId, String? metricsId, String gender, int? bodyLevel, String fitnessGoal) async {
    // if 0 then A, if 1 then B, if 2 then C, if 3 then D
    String bodyLevelString = '';
    switch (bodyLevel) {
      case 0:
        bodyLevelString = 'A';
        break;
      case 1:
        bodyLevelString = 'B';
        break;
      case 2:
        bodyLevelString = 'C';
        break;
      case 3:
        bodyLevelString = 'D';
        break;
    }
    List<String> workoutSchedule = generateWorkoutSchedule(gender, bodyLevelString, fitnessGoal);
    BodyMetrics? bodyMetrics = await getBodyMetrics(metricsId);

    if (bodyMetrics != null) {
      bodyMetrics.workoutSchedule = workoutSchedule;
      await updateBodyMetrics(metricsId, bodyMetrics);
    }
  }
  Future<void> updateBodyMetrics(String? id,BodyMetrics bodyMetrics) async {
    try {
      await _bodyMetricsRef.doc(id).update(bodyMetrics.toMap());
    } catch (e) {
      //print('Error updating body metrics: $e');
      throw e;
    }
  }
  Future<BodyMetrics?> getBodyMetrics(String? id) async {
    try {
      var snapshot = await _bodyMetricsRef.doc(id).get();
      if (snapshot.exists) {
        //print("Document exists: ${snapshot.data()}");
        var data = snapshot.data();
        if (data != null) {
          BodyMetrics? bb= BodyMetrics.fromMap(data as Map<String, dynamic>);
          for(int i=0;i<bb.workoutSchedule.length;++i){
            //print("hi");
            //print(bb.workoutSchedule[i]);
          }
          return BodyMetrics.fromMap(data as Map<String, dynamic>);
        } else {
          //print("Document data is null");
        }
      } else {
        //print("Document with ID $id does not exist");
      }
      return null; // Body metrics not found or data is null
    } catch (e) {
      //print('Error getting body metrics: $e');
      throw e;
    }

  }
  // Future<void> updateCurrentDay(String id) async {
  //   try {
  //     // Fetch the current body metrics
  //     var snapshot = await _bodyMetricsRef.doc(id).get();
  //     if (snapshot.exists && snapshot.data() != null) {
  //       // Convert the snapshot data to a BodyMetrics object
  //       BodyMetrics bodyMetrics = BodyMetrics.fromMap(snapshot.data() as Map<String, dynamic>);
  //        int currentday= bodyMetrics.CurrentDay;
  //       currentday=currentday+1;
  //
  //       await _bodyMetricsRef.doc(id).update({
  //         'CurrentDay': currentday,
  //       });
  //
  //       //print('Current day updated successfully.');
  //     } else {
  //       //print('Body metrics not found.');
  //     }
  //   } catch (e) {
  //     //print('Error updating current day: $e');
  //     throw e;
  //   }
  // }


  // Delete body metrics document from Firestore based on user ID
  Future<void> deleteBodyMetrics(String id) async {
    try {
      await _bodyMetricsRef.doc(id).delete();
    } catch (e) {
      //print('Error deleting body metrics: $e');
      throw e;
    }
  }
}