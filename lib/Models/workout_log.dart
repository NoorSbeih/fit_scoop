class WorkoutLog {
  final String id;
  final String userId;
  final String workoutId;
  final DateTime dateTime;
  final String? notes;

  WorkoutLog({
    required this.id,
    required this.userId,
    required this.workoutId,
    required this.dateTime,
    this.notes,
  });
}
