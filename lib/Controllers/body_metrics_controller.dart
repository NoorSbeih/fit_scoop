import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/body_metrics_model.dart';
import '../Services/Database Services/body_metrics_service.dart';



class BodyMetricsController {
  final BodyMetricsService _bodyMetricsService = BodyMetricsService();

  Future<void> addBodyMetrics(BodyMetrics bodyMetrics) async {
    try {
      await _bodyMetricsService.addBodyMetrics(bodyMetrics);
    } catch (e) {
      print('Error adding body metrics: $e');
      throw e;
    }
  }

  Future<void> updateCurrentDay(String? id) async {
    try {
      await _bodyMetricsService.updateCurrentDay(id!);
    } catch (e) {
      print('Error adding body metrics: $e');
      throw e;
    }
  }
  Future<void> updateBodyMetrics(String id,BodyMetrics bodyMetrics) async {
    try {
      // Update body metrics in the database using the BodyMetricsService
      await _bodyMetricsService.updateBodyMetrics(id,bodyMetrics);
    } catch (e) {
      print('Error updating body metrics: $e');
      throw e;
    }
  }

  Future<void> deleteBodyMetrics(String id) async {
    try {
      // Delete body metrics from the database using the BodyMetricsService
      await _bodyMetricsService.deleteBodyMetrics(id);
    } catch (e) {
      print('Error deleting body metrics: $e');
      throw e;
    }
  }
  Future<BodyMetrics?> fetchBodyMetrics(String? bodyMetrics) async {
    try {
      print("gjgjgj");
      return await _bodyMetricsService.getBodyMetrics(bodyMetrics);
    } catch (e) {
      print('Error getting : $e');
      throw e;
    }
  }
}
