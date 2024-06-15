
import 'dart:convert';
import 'dart:core';
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
   int CurrentDay;
   List<String> workoutSchedule;
   String unitOfMeasure;

  BodyMetrics({
    required this.userId,
    required this.height,
    required this.weight,
    required this.birthDate,
    required this.gender,
    required this.bodyFat,
    required this.fitnessGoal,
    required this.gymType,
    required this.CurrentDay,
    List<String>? workoutSchedule,
    required this.unitOfMeasure,
  }) : this.workoutSchedule =List.filled(7,'No workout');

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'height': height,
      'weight': weight,
      'birthDate': birthDate,
      'gender': gender,
      'bodyFat': bodyFat,
      'fitnessGoal': fitnessGoal,
      'gymType': gymType,
      'CurrentDay':CurrentDay,
      'workoutSchedule': workoutSchedule,
      'unitOfMeasure':unitOfMeasure
    };
  }


  Map<String, dynamic> toUpdateMap() {
    return {
      'CurrentDay': CurrentDay,
    };
  }

  factory BodyMetrics.fromMap(Map<String, dynamic> map) {
    return BodyMetrics(
      userId: map['userId'],
      height: map['height'],
      weight: map['weight'],
      birthDate: map['birthDate'],
      gender: map['gender'],
      bodyFat: map['bodyFat'],
      fitnessGoal:map['fitnessGoal'],
      gymType: map['gymType'],
      CurrentDay:map['CurrentDay'],
      workoutSchedule: (map['workoutSchedule'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? List.filled(7, 'No workout'),
     unitOfMeasure:map['unitOfMeasure'],
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
