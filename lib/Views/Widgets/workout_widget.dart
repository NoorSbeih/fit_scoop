import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../Models/workout_model.dart';
import '../Screens/library/workout_detail_screen.dart';

class workout_widget {
  static Widget customcardWidget(Workout workout,isSelected, BuildContext context,Function(Workout, bool) updateSavedWorkouts) {

    int intensity = 0;
    if (workout.intensity == "Beginner") {
      intensity = 1;
    } else if (workout.intensity == "Intermediate") {
      intensity = 2;
    } else if (workout.intensity == "Advanced") {
      intensity = 3;
    }
    return SizedBox(
      height: 110,

      child: Card(
        margin: const EdgeInsets.only(left:20,right:20,top:15),
        color: const Color(0xFF2C2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isSelected ? Color(0xFF0dbab4) : Colors.white,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBar.builder(
                    initialRating: intensity.toDouble(),
                    direction: Axis.horizontal,
                    itemCount: 3,
                    tapOnlyMode: true,
                    itemPadding: EdgeInsets.all(0),
                    itemSize: 26.0,
                    itemBuilder: (context, _) => Transform.scale(
                      scale: 0.7,
                      child: const Icon(
                        Icons.star,
                        color: Color(0xFF0dbab4),
                      ),
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workout.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${workout.duration} MINS | ${workout.exercises.length} EXERCISES',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              const Spacer(),
                // onTap: () {
                //     showModalBottomSheet(
                //       context: context,
                //       isScrollControlled: true,
                //       shape: const RoundedRectangleBorder(
                //         borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                //       ),
                //       builder: (BuildContext context) {
                //         return Container(
                //           height: MediaQuery.of(context).size.height * 0.95,
                //           decoration: BoxDecoration(
                //             borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                //             border: Border.all(
                //               width: 2.0,
                //             ),
                //           ),
                //           child:DetailPage(workout: workout, updateSavedWorkouts: updateSavedWorkouts,),
                //         );
                //       },
                //     );
                // },
                GestureDetector(
                  onTap: () {
                    showCustomDialog(context, workout, updateSavedWorkouts);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Icon(
                      Icons.more_horiz_outlined,
                      color: Color(0xFF0dbab4),
                    ),
                  ),
                ),


            ],
          ),
        ),
      ),
    );
  }
}
void showCustomDialog(BuildContext context, Workout workout, Function(Workout, bool) updateSavedWorkouts) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    pageBuilder: (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
      return Center(
        child: FractionallySizedBox(
          heightFactor: 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: DetailPage(workout: workout, updateSavedWorkouts: updateSavedWorkouts),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ).drive(Tween<Offset>(
          begin: const Offset(0, 1.0),
          end: Offset.zero,
        )),
        child: child,
      );
    },
  );
}

