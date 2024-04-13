import 'body_metrics_model.dart';

enum UnitMeasure { imperial, metric }

class User {
  final String id;
  final String name;
  final String email;
  final String? profilePictureUrl;
  final BodyMetrics? bodyMetrics;
  final List<String> followedUserIds; // References to User IDs
  final List<String> savedWorkoutIds; // References to Workout IDs

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    this.bodyMetrics,
    this.followedUserIds = const [],
    this.savedWorkoutIds = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'bodyMetrics': bodyMetrics?.toMap(), // Assuming BodyMetrics has a toMap() method
      'followedUserIds': followedUserIds,
      'savedWorkoutIds': savedWorkoutIds,
    };
  }
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePictureUrl: map['profilePictureUrl'],
      bodyMetrics: BodyMetrics.fromMap(map['bodyMetrics']),
      followedUserIds: List<String>.from(map['followedUserIds']),
      savedWorkoutIds: List<String>.from(map['savedWorkoutIds']),
    );
  }

}
