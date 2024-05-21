import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Models/user_singleton.dart';
import 'package:fit_scoop/Views/Screens/add/createworkout1.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import '../../../Controllers/exercise_controller.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/exercise_model.dart';
import '../../../Models/workout_model.dart';
class AddExercisePage extends StatelessWidget {
  final OnExerciseAddedCallback onExerciseAdded;
  AddExercisePage({required this.onExerciseAdded});

    @override
    Widget build(BuildContext context) {
      return   Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFF2C2A2A),
          appBar: AppBar(
          backgroundColor: Color(0xFF2C2A2A),
      leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xFF0dbab4),),
      onPressed: () {
      Navigator.pop(context);
      onExerciseAdded();
      },
      ),
      actions: [
      IconButton(
      icon: const Icon(Icons.settings, color: Color(0xFF0dbab4),),
      onPressed: () {
      // Handle menu icon pressed
      },
      ),
      ],

      ),
     body: addExercise(),
      );

    }


}

class addExercise extends StatefulWidget {

  static final List<Map<String, dynamic>> exercises=[];


  @override
  _addExercise createState() => _addExercise();
}

class _addExercise  extends State<addExercise> with SingleTickerProviderStateMixin {
  late TabController _tabController;



  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
       appBar:TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          dividerColor: const Color(0xFF2C2A2A),
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          indicatorColor: const Color(0xFF0dbab4),
          tabs: const [
            Tab(text: 'ALPHABETICAL'),
            Tab(text: 'MUSCLE GROUP'),
          ],

        ),
      body:TabBarView(
        controller: _tabController,
        children: [
          alphabeticalTabContent(),
          muscleGroupTabContent(), // Call the function here
        ],
      ),

      );



  }
  Widget alphabeticalTabContent() {
    List<String> alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    ExerciseController controller=new ExerciseController();
    return ListView(
      children: alphabet.map((letter) {
        return ExpansionTile(
          title: custom_widget.customTextWidgetForExersiceCard(letter,16),
          children: [
            FutureBuilder<List<Exercise>>(
              future:controller.getExercisesByStartingLetter(letter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = snapshot.data![index];
                      return exercises_card.addingExersiceWidget(
                        exercise.name,
                        exercise.id,
                        context,
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No exercises found.'));
                }
              },
            ),
          ],
        );
      }).toList(),
    );

  }
  Widget muscleGroupTabContent() {

    List<String> mainMuscles = ['chest', 'Back', 'Legs'];
    ExerciseController controller=new ExerciseController();
    return ListView(
      children: mainMuscles.map((mainMuscle) {
        return ExpansionTile(
          title: custom_widget.customTextWidgetForExersiceCard(mainMuscle,16),
          children: [
            FutureBuilder<List<Exercise>>(
              future:controller.getExercisesByMainMuscle(mainMuscle),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = snapshot.data![index];
                     return exercises_card.addingExersiceWidget(
                        exercise.name,
                       exercise.id,
                       context,
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No exercises found.'));
                }
              },
            ),
          ],
        );
      }).toList(),
    );
  }

}