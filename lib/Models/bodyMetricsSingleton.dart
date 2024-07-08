
import 'package:fit_scoop/Models/body_metrics_model.dart';
class  BodyMetricsSingleton{
  static final BodyMetricsSingleton _instance = BodyMetricsSingleton._internal();
  late BodyMetrics _mertics;

  factory BodyMetricsSingleton() {
    return _instance;
  }

  BodyMetricsSingleton._internal();

  static BodyMetricsSingleton getInstance() {
    return _instance;
  }

  void setBodyMetrics(BodyMetrics mertics) {
    _mertics = mertics;
  }

  BodyMetrics getMetrices() {
    return _mertics;
  }



}
