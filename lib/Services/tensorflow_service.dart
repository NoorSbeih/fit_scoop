import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';

class TensorFlowService {
  late Interpreter _interpreter;
  bool _isModelLoaded = false;

  TensorFlowService() {
    _loadModel();
  }

  Future<void> _loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset('assets/bodyPerformance_model.tflite');
      _isModelLoaded = true;
    } catch (e) {
      print('Failed to load model: $e');
    }
  }

  Future<int> predict({
    required double age,
    required String gender,
    required double height,
    required double weight,
    required double bodyFat,
    required double diastolic,
    required double systolic,
    required double sitUps,
    required double broadJump,
  }) async {
    if (!_isModelLoaded) {
      return -1;
    }

    try {
      List<double> input = [
        age,
        gender.toLowerCase() == 'm' ? 0.0 : 1.0,
        height,
        weight,
        bodyFat,
        diastolic,
        systolic,
        sitUps,
        broadJump,
      ];

      // Normalize the input data using the mean and std values from training
      List<double> mean = [ 36.85420945,  0.37026321, 168.51080829,  67.40768527,  23.26696029,
        78.73297555, 130.24313048,  39.72549935 ,189.99114243];
      List<double> std = [13.64862215,  0.4828751,   8.45701  ,  11.91464331 , 7.27463843 ,10.69397483,
        14.70495999 ,14.2348735 , 39.79905327];

      List<double> normalizedInput = [];
      for (int i = 0; i < input.length; i++) {
        normalizedInput.add((input[i] - mean[i]) / std[i]);
      }

      // Convert the normalized input to a Float32List for TensorFlow Lite
      var inputByteData = Float32List.fromList(normalizedInput).reshape([1, 9]);

      // Prepare the output buffer
      var output = Float32List(4).reshape([1, 4]);

      // Run inference
      _interpreter.run(inputByteData, output);

      // Get the predicted class with the highest probability
      int predictedClass = 0;
      double maxValue = output[0][0];
      for (int i = 1; i < output[0].length; i++) {
        if (output[0][i] > maxValue) {
          maxValue = output[0][i];
          predictedClass = i;
        }
      }

      return predictedClass;
    } catch (e) {
      print('Error during prediction: $e');
      return -2;
    }
  }
}
