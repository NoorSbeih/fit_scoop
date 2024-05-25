
import '../Models/review_model.dart';
import '../Models/workout_model.dart';
import '../Services/Database Services/community_service.dart';

class CommunityPageController {
  final CommunityService _communityService = CommunityService();

  Future<List<dynamic>> getRecentActivities(String userId) async {
    List<String> followedUserIds = await _communityService.getFollowingUserIds(userId);

    List<Review> reviews = await _communityService.getRecentReviews(followedUserIds);
    List<Workout> workouts = await _communityService.getRecentWorkouts(followedUserIds);

    List<dynamic> activities = [];
    activities.addAll(reviews);
    activities.addAll(workouts);

    // activities.sort((a, b) {
    //   DateTime dateA = (a is Review) ? a.timestamp : (a as Workout).timestamp;
    //   DateTime dateB = (b is Review) ? b.timestamp : (b as Workout).timestamp;
    //   return dateB.compareTo(dateA);
    // });

    return activities;
  }







}
