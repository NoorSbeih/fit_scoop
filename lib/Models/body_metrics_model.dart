import 'dart:convert';
import 'dart:core';

import 'package:fit_scoop/Models/workout_model.dart';

class BodyMetrics {
  final String userId; // User ID associated with these metrics
  double height;
  double weight;
  String birthDate;
  String gender;
  double bodyFat;
  String fitnessGoal;
  String gymType;
  List<String> workoutSchedule;
  String unitOfMeasure;
  double? diastolic;
  double? systolic;
  double? sitUpCount;
  double? broadJumpCm;
  int? performanceLevel;


  BodyMetrics({
    required this.userId,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.gender,
    required this.bodyFat,
    required this.fitnessGoal,
    required this.gymType,
    List<String>? workoutSchedule,
    required this.unitOfMeasure,
    this.diastolic,
    this.systolic,
    this.sitUpCount,
    this.broadJumpCm,
    this.performanceLevel,

  }) : this.workoutSchedule = workoutSchedule ?? List.filled(7, 'No workout'); // Ensure the default value is only used if workoutSchedule is null

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'height': height,
      'weight': weight,
      'birthDate': birthDate,
      'gender': gender,
      'bodyFat': bodyFat,
      'fitnessGoal': fitnessGoal,
      'workoutSchedule': workoutSchedule,
      'unitOfMeasure': unitOfMeasure,
      'diastolic': diastolic,
      'systolic': systolic,
      'gymsType': gymType,
      'sitUpCount': sitUpCount,
      'broadJumpCm': broadJumpCm,
      'performanceLevel': performanceLevel,
    };
  }

  factory BodyMetrics.fromMap(Map<String, dynamic> map) {
    print("Mapping data from Firestore: $map");

    List<String> workoutSchedule = (map['workoutSchedule'] as List<dynamic>?)
        ?.map((e) => e.toString())
        .toList()
        ?? List<String>.filled(7, 'No workout');

    // Ensure the workoutSchedule has exactly 7 elements
    if (workoutSchedule.length < 7) {
      workoutSchedule = List.from(workoutSchedule)..addAll(List.filled(7 - workoutSchedule.length, 'No workout'));
    } else if (workoutSchedule.length > 7) {
      workoutSchedule = workoutSchedule.sublist(0, 7);
    }

    print("Parsed workoutSchedule: $workoutSchedule");

    return BodyMetrics(
      userId: map['userId'],
      height: map['height'],
      weight: map['weight'],
      birthDate: map['birthDate'],
      gender: map['gender'],
      bodyFat: map['bodyFat'],
      fitnessGoal: map['fitnessGoal'],
      workoutSchedule: workoutSchedule,
      unitOfMeasure: map['unitOfMeasure'],
      diastolic: map['diastolic'],
      systolic: map['systolic'],
      gymType: map['gymType'],
      sitUpCount: map['sitUpCount'],
      broadJumpCm: map['broadJumpCm'],
      performanceLevel: map['performanceLevel'],
    );
  }
}



/*List<String> convert(List<dynamic> x){
List<dynamic> fitnessGoalList =x;
List<String> fitnessGoal = fitnessGoalList.cast<String>();
return fitnessGoal;
}
List<List<String>> convert2(dynamic x) {
  if (x is List<dynamic>) {

    return x.map((dynamic item) {
      if (item is List<dynamic>) {
        return item.map((dynamic innerItem) => innerItem.toString()).toList();
      } else {
        return [item.toString()];
      }
    }).toList();
  } else if (x is String) {
    try {
      List<dynamic> parsedList = jsonDecode(x);
      if (parsedList is List<dynamic>) {
        return convert2(parsedList);
      }
    } catch (e) {
      print('Error parsing workout schedule JSON: $e');
    }
  }
  return [];
}*/
