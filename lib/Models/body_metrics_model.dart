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
    //print("Mapping data from Firestore: $map");

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



    return BodyMetrics(
      userId: map['userId'] ?? '',
      height: (map['height'] as num?)?.toDouble() ?? 0.0,
      weight: (map['weight'] as num?)?.toDouble() ?? 0.0,
      birthDate: map['birthDate'] ?? '',
      gender: map['gender'] ?? '',
      bodyFat: (map['bodyFat'] as num?)?.toDouble() ?? 0.0,
      fitnessGoal: map['fitnessGoal'] ?? '',
      workoutSchedule: workoutSchedule,
      unitOfMeasure: map['unitOfMeasure'] ?? '',
      diastolic: (map['diastolic'] as num?)?.toDouble(),
      systolic: (map['systolic'] as num?)?.toDouble(),
      gymType: map['gymsType'] ?? '',
      sitUpCount: (map['sitUpCount'] as num?)?.toDouble(),
      broadJumpCm: (map['broadJumpCm'] as num?)?.toDouble(),
      performanceLevel: (map['performanceLevel'] is String && map['performanceLevel'].isEmpty)
          ? null
          : (map['performanceLevel'] as num?)?.toInt(),
    );
  }
}
