import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class WorkoutPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WorkoutPagee (),
    );
  }
}
class WorkoutPagee extends StatefulWidget{


  const WorkoutPagee ({Key? key}) : super(key: key);

  @override
  State<WorkoutPagee > createState() => _WorkoutPageState();
}
class _WorkoutPageState extends State<WorkoutPagee> {
  @override
  Widget build(BuildContext context) {
  return Scaffold();
  }
}