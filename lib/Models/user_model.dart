import 'body_metrics_model.dart';

enum UnitMeasure { imperial, metric }

class User_model {
  final String id;
  final String name;
  final String email;
  final String? profilePictureUrl;
  final String? bodyMetrics;
  final List<String> followedUserIds; // References to User IDs
  final List<String> savedWorkoutIds; // References to Workout IDs
  final String? bio;
  final String? imageLink;

  User_model({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    this.bodyMetrics,
    this.followedUserIds = const [],
    this.savedWorkoutIds = const [],
    this.bio,
    this.imageLink
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'bodyMetrics': bodyMetrics, // Assuming BodyMetrics has a toMap() method
      'followedUserIds': followedUserIds,
      'savedWorkoutIds': savedWorkoutIds,
      'bio': bio,
      'imageLink':imageLink,
    };
  }
  factory User_model.fromMap(Map<String, dynamic> map) {
    return User_model(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      profilePictureUrl: map['profilePictureUrl'],
      bodyMetrics: map['bodyMetrics'],
      followedUserIds: List<String>.from(map['followedUserIds']),
      savedWorkoutIds: List<String>.from(map['savedWorkoutIds']),
      bio: map['bio'],
      imageLink:map['imageLink']
    );
  }


}
