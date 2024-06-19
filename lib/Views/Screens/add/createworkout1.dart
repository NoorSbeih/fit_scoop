import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../../Widgets/drawer_widget.dart';
import 'addExercise.dart';
import 'createworkout2.dart';

typedef void OnExerciseAddedCallback();

class createWorkout1 extends StatefulWidget {
  static String name = "";

  @override
  _createWorkout1 createState() => _createWorkout1();
}

class _createWorkout1 extends State<createWorkout1> {
  TextEditingController nameController = new TextEditingController();
  String emailErrorText = '';

  String errorText = '';

  @override
  void initState() {
    super.initState();
  }

  void handleExerciseAdded() {
    setState(() {
      retrieveAddedExercise(addExercise.exercises);
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      retrieveAddedExercise(addExercise.exercises);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C2A2A),
        iconTheme: const IconThemeData(
          color: Color(0xFF0dbab4), // Change the drawer icon color here
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF0dbab4)),
            onPressed: () {},
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: TextField(
                controller: nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Workout Name',
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                  errorText: emailErrorText.isNotEmpty ? emailErrorText : null,
                  errorStyle: TextStyle(color: Colors.red, fontSize: 14),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (text) {
                  setState(() {
                    emailErrorText = '';
                    createWorkout1.name = text;
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: addExercise.exercises.isEmpty
                    ? Center(
                  child: Text(
                    errorText,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                )
                    : retrieveAddedExercise(addExercise.exercises),
              ),
            ),
            _buildAddExerciseButton(context),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 16.0, right: 16, bottom: 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (createWorkout1.name.isEmpty) {
                    setState(() {
                      emailErrorText = 'Please enter name for the workout';
                    });
                  } else {
                    setState(() {
                      emailErrorText = '';
                    });
                  }

                  if (addExercise.exercises.isEmpty) {
                    setState(() {
                      errorText = 'Please choose exercises for the workout ';
                    });
                  }
                  if(!createWorkout1.name.isEmpty && !addExercise.exercises.isEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => createWorkout2()),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF0dbab4)),
                  fixedSize: MaterialStateProperty.all<Size>(const Size(350, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      );
                    },
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2C2A2A),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddExerciseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: GestureDetector(
        onTap: () async {
          setState(() {
            createWorkout1.name = nameController.text;
            print(createWorkout1.name);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AddExercisePage(onExerciseAdded: handleExerciseAdded),
              ),
            );
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'images/plus_unclicked.svg',
              width: 50,
              height: 60,
              color: Color(0xFF0dbab4),
            ),
            SizedBox(width: 15), // Add some space between the icon and text
            custom_widget.customTextWidget("ADD EXERCISE", 18),
          ],
        ),
      ),
    );
  }

  Widget retrieveAddedExercise(List<Map<String, dynamic>> exercises) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> exercise = exercises[index];
          String id = exercise['id'];
          final name = exercise['name'];
          final sets = exercise['sets'];
          final weight = exercise['weight'];
          if (name != null && sets != null && weight != null) {
            return exercises_card.AfterAddingExerciseCardWidget(
              name.toString(),
              sets.toString(),
              weight.toString(),
              context,
              id,
              0,
              onDelete: () {
                deleteExercise(id);
              },
            );
          } else {
            return SizedBox(); // Placeholder widget, replace it with your preferred widget
          }
        },
      ),
    );
  }

  void deleteExercise(String id) {
    int index = addExercise.exercises.indexWhere((exercise) => exercise['id'] == id);
    setState(() {
      addExercise.exercises.removeAt(index); // Remove the exercise from the list
    });
  }
}
