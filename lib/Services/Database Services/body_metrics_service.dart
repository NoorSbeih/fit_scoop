// services/database_services/body_metrics_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Models/body_metrics_model.dart';

class BodyMetricsService {
  final CollectionReference _bodyMetricsRef = FirebaseFirestore.instance.collection('bodyMetrics');
  final CollectionReference _usersRef = FirebaseFirestore.instance.collection('users');
  Future<void> addBodyMetrics(BodyMetrics bodyMetrics) async {
    try {
      DocumentReference documentRef = await _bodyMetricsRef.add(bodyMetrics.toMap());
      String documentId = documentRef.id;
      await _usersRef.doc(bodyMetrics.user_id).update({'bodyMetrics':documentId});
    } catch (e) {
      print('Error adding body metrics: $e');
      throw e;
    }
  }

  Future<void> updateBodyMetrics(BodyMetrics bodyMetrics) async {
    try {
     // await _bodyMetricsRef.doc(bodyMetrics.id).update(bodyMetrics.toMap
    } catch (e) {
      print('Error updating body metrics: $e');
      throw e;
    }
  }

  // Retrieve body metrics document from Firestore based on user ID
  Future<BodyMetrics?> getBodyMetrics(String id) async {
    try {
      var snapshot = await _bodyMetricsRef.doc(id).get();
      if (snapshot.exists && snapshot.data() != null) {
        return BodyMetrics.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null; // Body metrics not found
    } catch (e) {
      print('Error getting body metrics: $e');
      throw e;
    }
  }

  // Delete body metrics document from Firestore based on user ID
  Future<void> deleteBodyMetrics(String id) async {
    try {
      await _bodyMetricsRef.doc(id).delete();
    } catch (e) {
      print('Error deleting body metrics: $e');
      throw e;
    }
  }
}