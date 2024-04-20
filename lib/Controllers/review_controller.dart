import '../Models/review_model.dart';
import '../Services/Database Services/review_service.dart';


class ReviewController {
  final ReviewService _reviewService = ReviewService();

  Future<void> addReview(Review review) async {
    try {
      // Add review to the database using the ReviewService
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
  
// Add more methods as needed
}
