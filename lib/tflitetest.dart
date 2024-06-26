import 'package:flutter/material.dart';
import 'Services/tensorflow_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Body Performance Prediction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PredictionPage(),
    );
  }
}
class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}
class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _genderController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _bodyFatController = TextEditingController();
  final _diastolicController = TextEditingController();
  final _systolicController = TextEditingController();
  final _sitUpsController = TextEditingController();
  final _broadJumpController = TextEditingController();

  String _predictionResult = '';
  final TensorFlowService _tensorflowService = TensorFlowService();

  Future<void> predict() async {
    if (_formKey.currentState?.validate() ?? false) {
      int result = await _tensorflowService.predict(
        age: double.parse(_ageController.text),
        gender: _genderController.text,
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        bodyFat: double.parse(_bodyFatController.text),
        diastolic: double.parse(_diastolicController.text),
        systolic: double.parse(_systolicController.text),
        sitUps: double.parse(_sitUpsController.text),
        broadJump: double.parse(_broadJumpController.text),
      );

      setState(() {
        _predictionResult = result.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Performance Prediction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              buildTextFormField(_ageController, 'Age'),
              buildTextFormField(_genderController, 'Gender (M/F)', keyboardType: TextInputType.text),
              buildTextFormField(_heightController, 'Height (cm)'),
              buildTextFormField(_weightController, 'Weight (kg)'),
              buildTextFormField(_bodyFatController, 'Body Fat (%)'),
              buildTextFormField(_diastolicController, 'Diastolic'),
              buildTextFormField(_systolicController, 'Systolic'),
              buildTextFormField(_sitUpsController, 'Sit-Ups Count'),
              buildTextFormField(_broadJumpController, 'Broad Jump (cm)'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: predict,
                child: Text('Predict'),
              ),
              SizedBox(height: 20),
              Text(
                'Prediction Result: $_predictionResult',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.number}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Gender (M/F)' && !(value.toLowerCase() == 'm' || value.toLowerCase() == 'f')) {
          return 'Please enter M or F';
        }
        return null;
      },
    );
  }
}

