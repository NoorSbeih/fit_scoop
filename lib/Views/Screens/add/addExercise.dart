import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Models/user_singleton.dart';
import 'package:fit_scoop/Views/Screens/add/createworkout1.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import '../../../Controllers/exercise_controller.dart';
import '../../../Controllers/workout_controller.dart';
import '../../../Models/bodyPart.dart';
import '../../../Models/exercise_model.dart';
import '../../../Models/workout_model.dart';

class AddExercisePage extends StatelessWidget {
  final OnExerciseAddedCallback onExerciseAdded;

  AddExercisePage({required this.onExerciseAdded});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
      body: addExercise(),
    );
  }
}

class addExercise extends StatefulWidget {
  static final List<Map<String, dynamic>> exercises = [];

  @override
  _addExercise createState() => _addExercise();
}

class _addExercise extends State<addExercise>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String imageUrl = "";

  List<BodyPart> parts = [];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchBodyParts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  Future<void> fetchBodyParts() async {
    try {
      ExerciseController controller = ExerciseController();
      List<BodyPart> equipments = await controller.getAllBoyImages();
      setState(() {
        parts = equipments;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String getImageUrl(Exercise exercise) {
    for (int i = 0; i < parts.length; i++) {
      if (parts[i].name == exercise.bodyPart) {
        return parts[i].imageUrl;
      }
      if (parts[i].name != exercise.bodyPart && parts[i].name == exercise.target) {
        return parts[i].imageUrl;
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF0dbab4),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'SEARCH EXERSICES...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
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
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          alphabeticalTabContent(),
          muscleGroupTabContent(),
        ],
      ),
    );
  }

  Widget alphabeticalTabContent() {
    List<String> alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
    ExerciseController controller = new ExerciseController();
    return ListView(
      children: alphabet.map((letter) {
        return ExpansionTile(
          title: custom_widget.customTextWidgetForExersiceCard(letter, 16),
          children: [
            FutureBuilder<List<Exercise>>(
              future: controller.getExercisesByStartingLetter(letter.toLowerCase()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Exercise> filteredExercises = snapshot.data!.where((exercise) {
                    return exercise.name.toLowerCase().contains(_searchQuery);
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = filteredExercises[index];

                      return exercises_card.addingExersiceWidget(
                        exercise.name,
                        exercise.id,
                        getImageUrl(exercise),
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
    List<String> mainMuscles = [
      'waist',
      'back',
      'chest',
      'upper arms',
      'upper legs',
      'shoulders',
      'lower arms',
      'cardio',
      'lower legs'
    ];
    ExerciseController controller = new ExerciseController();
    return ListView(
      children: mainMuscles.map((mainMuscle) {
        return ExpansionTile(
          title: custom_widget.customTextWidgetForExersiceCard(mainMuscle, 16),
          children: [
            FutureBuilder<List<Exercise>>(
              future: controller.getExercisesByMainMuscle(mainMuscle),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Exercise> filteredExercises = snapshot.data!.where((exercise) {
                    return exercise.name.toLowerCase().contains(_searchQuery);
                  }).toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filteredExercises.length,
                    itemBuilder: (context, index) {
                      Exercise exercise = filteredExercises[index];

                      return exercises_card.addingExersiceWidget(
                        exercise.name,
                        exercise.id,
                        getImageUrl(exercise),
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
