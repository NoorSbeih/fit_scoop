// services/database_services/review_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/review_model.dart';


class ReviewService {
  final CollectionReference _reviewsRef = FirebaseFirestore.instance.collection('reviews');

  // Add new review document to Firestore
  Future<void> addReview(Review review) async {
    try {
      await _reviewsRef.doc(review.id).set(review.toMap());
    } catch (e) {
      print('Error adding review: $e');
      throw e;
    }
  }

  // Update existing review document in Firestore
  Future<void> updateReview(Review review) async {
    try {
      await _reviewsRef.doc(review.id).update(review.toMap());
    } catch (e) {
      print('Error updating review: $e');
      throw e;
    }
  }

  // Retrieve review document from Firestore based on review ID
  Future<Review?> getReview(String id) async {
    try {
      var snapshot = await _reviewsRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        return Review.fromMap(id, snapshot.data() as Map<String, dynamic>);
      }
      return null; // Review not found
    } catch (e) {
      print('Error getting review: $e');
      throw e;
    }
  }

  // Delete review document from Firestore based on review ID
  Future<void> deleteReview(String id) async {
    try {
      await _reviewsRef.doc(id).delete();
    } catch (e) {
      print('Error deleting review: $e');
      throw e;
    }
  }


  Future<List<Review>> getReviewsByWorkoutId(String workoutId) async {
    try {
      QuerySnapshot snapshot = await _reviewsRef.where('workoutId', isEqualTo: workoutId).get();
      List<Review> reviews = snapshot.docs.map((doc) => Review.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
      return reviews;
    } catch (e) {
      print('Error getting reviews by workout ID: $e');
      throw e;
    }
  }

  Future<List<Review>> getReviewsByUserId(String userId) async {
    try {
      QuerySnapshot snapshot = await _reviewsRef.where('reviewingUserId', isEqualTo: userId).get();
      List<Review> reviews = snapshot.docs.map((doc) => Review.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
      return reviews;
    } catch (e) {
      print('Error getting reviews by user ID: $e');
      throw e;
    }
  }


}
