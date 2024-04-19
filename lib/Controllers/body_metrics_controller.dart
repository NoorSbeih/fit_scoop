import '../Models/body_metrics_model.dart';
import '../Services/Database Services/body_metrics_service.dart';



class BodyMetricsController {
  final BodyMetricsService _bodyMetricsService = BodyMetricsService();

  Future<void> addBodyMetrics(BodyMetrics bodyMetrics) async {
    try {
      // Add body metrics to the database using the BodyMetricsService
      await _bodyMetricsService.addBodyMetrics(bodyMetrics);
    } catch (e) {
      print('Error adding body metrics: $e');
      throw e;
    }
  }

  Future<void> updateBodyMetrics(BodyMetrics bodyMetrics) async {
    try {
      // Update body metrics in the database using the BodyMetricsService
      await _bodyMetricsService.updateBodyMetrics(bodyMetrics);
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
 
  Future<BodyMetrics?> fetchBodyMetrics(String userid) async {
    try {
      // Fetch body metrics from the database using the BodyMetricsService
      return await _bodyMetricsService.getBodyMetrics(userid);
    } catch (e) {
      print('Error fetching body metrics: $e');
      throw e;
    }
  }

// Add more methods as needed
}
