import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/review_model.dart';
import '../../Models/workout_model.dart';


class CommunityService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Review>> getRecentReviews(List<String> followedUserIds) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('reviews')
        .where('reviewingUserId', whereIn: followedUserIds)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();
     print('Fetched Review Documents: ${querySnapshot.docs.length}');
    querySnapshot.docs.forEach((doc) {
      print('Review Document Data: ${doc.data()}');
    });

    List<Review> reviews = querySnapshot.docs.map((doc) {
      return Review.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
    return reviews;
  }

  Future<List<Workout>> getRecentWorkouts(List<String> followedUserIds) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('workouts')
        .where('creatorId', whereIn: followedUserIds)
        .where('isPrivate', isEqualTo: false)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();
    print( followedUserIds[1]);
    print('Fetched: ${querySnapshot.docs.length}');
    querySnapshot.docs.forEach((doc) {
      print('Review Document Data: ${doc.data()}');
    });

    List<Workout> workouts = querySnapshot.docs.map((doc) {
      return Workout.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();

    // Return the mapped results
    return workouts;
  }

  Future<List<String>> getFollowingUserIds(String userId) async {
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
    List<dynamic> following = userDoc.get('followedUserIds');
    return List<String>.from(following);
  }
}

