import 'package:fit_scoop/Models/review_model.dart';
import 'package:fit_scoop/Models/workout_model.dart';

import 'exercise_model.dart';

class CommunityWorkout extends Workout {
  final String sharingUserId;
  final int numberOfSaves;
  final List<Review> reviews;

  CommunityWorkout({
    required super.id,
    required super.name,
    super.description,
    required super.exercises,
    required super.duration,
    super.intensity,
    required super.creatorId,
    required this.sharingUserId,
    required this.numberOfSaves,
    required this.reviews,
  });
}
