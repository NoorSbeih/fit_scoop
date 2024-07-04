import 'body_metrics_model.dart';

enum UnitMeasure { imperial, metric }

class User_model {
   String id;
   String name;
   String email;
   String? profilePictureUrl;
   String? bodyMetrics;
   List<String> followedUserIds;
   List<String> followersUserIds;// References to User IDs
   List<String> savedWorkoutIds; // References to Workout IDs
   List<String> savedEquipmentIds;
    String? bio;
   String? imageLink;

  User_model({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    this.bodyMetrics,
    this.followedUserIds = const [],
    this.followersUserIds=const[],
    this.savedWorkoutIds = const [],
    this.savedEquipmentIds=const[],
    this.bio,
    this.imageLink,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'bodyMetrics': bodyMetrics, // Assuming BodyMetrics has a toMap() method
      'followedUserIds': followedUserIds,
      'followersUserIds':followersUserIds,
      'savedWorkoutIds': savedWorkoutIds,
      'savedEquipmentIds':savedEquipmentIds,
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
      followersUserIds: List<String>.from(map['followersUserIds']),
      savedWorkoutIds: List<String>.from(map['savedWorkoutIds']),
      savedEquipmentIds: List<String>.from(map['savedEquipmentIds']),
      bio: map['bio'],
      imageLink:map['imageLink'],
    );
  }


}
