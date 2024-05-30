import 'body_metrics_model.dart';

enum UnitMeasure { imperial, metric }

class User_model {
   String id;
   String name;
   String email;
   String? profilePictureUrl;
   String? bodyMetrics;
   List<String> followedUserIds; // References to User IDs
   List<String> savedWorkoutIds; // References to Workout IDs
   List<String> savedEquipmentIds;
    String? bio;
   String? imageLink;
   String? unitOfMeasure;

  User_model({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    this.bodyMetrics,
    this.followedUserIds = const [],
    this.savedWorkoutIds = const [],
    this.savedEquipmentIds=const[],
    this.bio,
    this.imageLink,
    this.unitOfMeasure,
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
      'savedEquipmentIds':savedEquipmentIds,
      'bio': bio,
      'imageLink':imageLink,
      'unitOfMeasure':unitOfMeasure,
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
      savedEquipmentIds: List<String>.from(map['savedEquipmentIds']),
      bio: map['bio'],
      imageLink:map['imageLink'],
        unitOfMeasure:map['unitOfMeasure']
    );
  }


}
