

class Review {
 String? id;
  final String workoutId;
  final String reviewingUserId;
  final int rating;
  final String comment;

  Review({
     this.id,
    required this.workoutId,
    required this.reviewingUserId,
    required this.rating,
    required this.comment,
  });

  // Convert ReviewModel to a map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workoutId': workoutId,
      'reviewingUserId': reviewingUserId,
      'rating': rating,
      'comment': comment,
    };
  }

  // Convert Firestore data to ReviewModel
  factory Review.fromMap(String id, Map<String, dynamic> map) {
    return Review(
      id: id,
      workoutId: map['workoutId'],
      reviewingUserId: map['reviewingUserId'],
      rating: map['rating'],
      comment: map['comment'],
    );
  }
}
