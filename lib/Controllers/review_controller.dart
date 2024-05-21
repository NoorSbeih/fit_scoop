import '../Models/review_model.dart';
import '../Services/Database Services/review_service.dart';


class ReviewController {
  final ReviewService _reviewService = ReviewService();

  Future<void> addReview(Review review) async {
    try {

      await _reviewService.addReview(review);
    } catch (e) {
      print('Error adding review: $e');
      throw e;
    }
  }

  Future<void> updateReview(Review review) async {
    try {
      // Update review in the database using the ReviewService
      await _reviewService.updateReview(review);
    } catch (e) {
      print('Error updating review: $e');
      throw e;
    }
  }

  Future<void> deleteReview(String id) async {
    try {
      // Delete review from the database using the ReviewService
      await _reviewService.deleteReview(id);
    } catch (e) {
      print('Error deleting review: $e');
      throw e;
    }
  }
  Future<List<Review>> getReviewsByWorkoutId(String? workoutId) async {
    try {
      // Get reviews for the specific workout ID from the database using the ReviewService
      return await _reviewService.getReviewsByWorkoutId(workoutId);
    } catch (e) {
      print('Error getting reviews for workout ID $workoutId: $e');
      throw e;
    }
  }
  Future<List<Review>> getReviewsByUserId(String userId) async {
    try {
      // Get reviews for the specific user ID from the database using the ReviewService
      return await _reviewService.getReviewsByUserId(userId);
    } catch (e) {
      print('Error getting reviews for user ID $userId: $e');
      rethrow;
    }
  }
}
