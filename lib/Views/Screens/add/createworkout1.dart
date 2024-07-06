import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
import 'package:fit_scoop/Views/Widgets/exercises_card_widget.dart';
import 'package:flutter_svg/svg.dart';
import '../../../Controllers/exercise_controller.dart';
import '../../../Models/bodyPart.dart';
import '../../../Models/exercise_model.dart';
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
  List<BodyPart> parts = [];
  Map<String, String> exerciseImageUrls = {};
  bool imagesLoading = true; // Track if images are still loading

  @override
  void initState() {
    super.initState();
    fetchBodyParts();
    prefetchImageUrls(); // Pre-fetch image URLs when initializing
  }

  void handleExerciseAdded() {
    setState(() {
      prefetchImageUrls(); // Pre-fetch image URLs when exercises are added
    });
  }

  Future<void> _handleRefresh() async {
    setState(() {
      prefetchImageUrls(); // Pre-fetch image URLs on refresh
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
      // Handle error
    }
  }

  Future<void> prefetchImageUrls() async {
    try {
      List<Future<String>> futures = []; // Explicitly typed as List<Future<String>>

      for (var exercise in addExercise.exercises) {
        String id = exercise['id'];
        futures.add(getImageUrl(id));
      }

      List<String> imageUrls = await Future.wait(futures);

      for (int i = 0; i < addExercise.exercises.length; i++) {
        String id = addExercise.exercises[i]['id'];
        exerciseImageUrls[id] = imageUrls[i];
      }

      // Update UI to reflect that images are no longer loading
      setState(() {
        imagesLoading = false;
      });
    } catch (e) {
      // Handle error
      print('Error fetching image URLs: $e');
    }
  }


  Future<String> getImageUrl(String id) async {
    ExerciseController controller = ExerciseController();
    Exercise? exerciseDetail = await controller.getExercise(id);
    String? bodyPart = exerciseDetail?.bodyPart;
    String? target = exerciseDetail?.target;

    // Find image URL based on body part or target
    for (var part in parts) {
      if (part.name == bodyPart || part.name == target) {
        return part.imageUrl;
      }
    }
    return ""; // Return empty string if no matching image found
  }
  // Future<void> prefetchImageUrls() async {
  //   for (var exercise in addExercise.exercises) {
  //     String id = exercise['id'];
  //     String imageUrl = await getImageUrl(exercise);
  //     setState(() {
  //       exerciseImageUrls[id] = imageUrl;
  //       print(exerciseImageUrls[id]);
  //     });
  //   }
  //   setState(() {
  //     imagesLoading = false; // Set loading to false after images are fetched
  //   });
  // }
  //
  // Future<String> getImageUrl(Map<String, dynamic> exercise) async {
  //   String id = exercise['id'];
  //   ExerciseController controller = ExerciseController();
  //   Exercise? exersice = await controller.getExercise(id);
  //   String? bodyPart = exersice?.bodyPart;
  //   String? target = exersice?.target;
  //
  //   for (int i = 0; i < parts.length; i++) {
  //     if (parts[i].name == bodyPart) {
  //       return parts[i].imageUrl;
  //     }
  //     if (parts[i].name != bodyPart && parts[i].name == target) {
  //       return parts[i].imageUrl;
  //     }
  //   }
  //   return "";
  // }

  Future<void> fetchExerciseImages() async {
    ExerciseController controller = ExerciseController();
    for (var exercise in addExercise.exercises) {
      String id = exercise['id'];
      Exercise? exerciseDetail = await controller.getExercise(id);
      String? bodyPart = exerciseDetail?.bodyPart;
      String? target = exerciseDetail?.target;

      for (var part in parts) {
        if (part.name == bodyPart || part.name == target) {
          setState(() {
            exerciseImageUrls[id] = part.imageUrl;
          });
          break;
        }
      }
    }
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
        title: const Text(
          'CREATE WORKOUT',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 20, // Adjust font size as needed
            fontWeight: FontWeight.bold, // Make the text bold
          ),
        ),
        centerTitle: true,
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
                child: imagesLoading
                    ? Center(
                    child: CircularProgressIndicator()) // Show loading indicator
                    : addExercise.exercises.isEmpty
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
                  if (!createWorkout1.name.isEmpty &&
                      !addExercise.exercises.isEmpty) {
                    await fetchExerciseImages(); // Fetch exercise images before navigating
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
                  fixedSize: MaterialStateProperty.all<Size>(
                      const Size(350, 50)),
                  shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (Set<MaterialState> states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      );
                    },
                  ),
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    fontSize: 22,
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
            String imageUrl = exerciseImageUrls[id] ?? ''; // Ensure imageUrl is not null
            return exercises_card.AfterAddingExerciseCardWidget(
              name.toString(),
              sets.toString(),
              weight.toString(),
              context,
              id,
              imageUrl, // Use pre-fetched image URL
              onDelete: () {
                deleteExercise(id);
              },
            );
          }
        },
      ),
    );
  }

  void deleteExercise(String id) {
    int index =
    addExercise.exercises.indexWhere((exercise) => exercise['id'] == id);
    setState(() {
      addExercise.exercises.removeAt(
          index); // Remove the exercise from the list
    });
  }
}
