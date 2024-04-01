class Review {
  final String id;
  final String workoutId;
  final String reviewingUserId;
  final int rating;
  final String comment;

  Review({
    required this.id,
    required this.workoutId,
    required this.reviewingUserId,
    required this.rating,
    required this.comment,
  });
}
