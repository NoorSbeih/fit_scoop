class WorkoutLog {
  String? id;
  final String userId;
  final String workoutId;
  final DateTime time;
  final Duration duration;
  final List<ExercisePerformed> exercisesPerformed;

  WorkoutLog({
    required this.userId,
    required this.workoutId,
    required this.time,
    required this.duration,
    required this.exercisesPerformed,
  });

  // Convert WorkoutLog to a map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'workoutId': workoutId,
      'timeTaken': time.toIso8601String(),
      'duration': duration.inMinutes,
      'exercisesPerformed': exercisesPerformed.map((e) => e.toMap()).toList(),
    };
  }

  factory WorkoutLog.fromMap(String id, Map<String, dynamic> map) {
    return WorkoutLog(
      userId: map['userId'],
      workoutId: map['workoutId'],
      time: DateTime.parse(map['timeTaken']),
      duration: Duration(minutes: map['duration']),
      exercisesPerformed: (map['exercisesPerformed'] as List)
          .map((e) => ExercisePerformed.fromMap(e))
          .toList(),
    );
  }
}

class ExercisePerformed {
  final String name;
  final int setsCompleted;

  ExercisePerformed({
    required this.name,
    required this.setsCompleted,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'setsCompleted': setsCompleted,
    };
  }

  factory ExercisePerformed.fromMap(Map<String, dynamic> map) {
    return ExercisePerformed(
      name: map['name'],
      setsCompleted: map['setsCompleted'],
    );
  }
}
