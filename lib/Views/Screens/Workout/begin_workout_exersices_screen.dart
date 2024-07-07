import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'exercise_details_screen.dart';

class BeginWorkoutCardWidget extends StatelessWidget {
  final String name;
  final String sets;
  final String weight;
  final String id;
  final int duration;
  final int remainingSets;
   String imageUrl;
  final ValueChanged<int> onRemainingCountChanged;

  BeginWorkoutCardWidget({
    Key? key,
    required this.name,
    required this.sets,
    required this.weight,
    required this.id,
    required this.duration,
    required this.imageUrl,
    required this.remainingSets,

    required this.onRemainingCountChanged
  }) : super(key: key);

  void onExerciseFinished(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.89,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
            border: Border.all(
              width: 2.0,
            ),
          ),
          child: ExerciseDetailsPage(
            id: id,
            sets: sets,
            duration: duration,
            onRemainingCountChanged: onRemainingCountChanged,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15),
        color: Color(0xFF2C2A2A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Opacity(
          opacity: remainingSets == 0 ? 0.5 : 1.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(8),
                height: double.infinity,
                width: 80,
                child:Image.asset(
                  imageUrl,
                  width: 148,
                  height: 128,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 7, top: 15),
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7, bottom: 10, top: 1),
                      child: Text(
                        "$sets | $weight",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: remainingSets > 0 ? () => onExerciseFinished(context) : null,
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Icon(
                    remainingSets == 0 ? Icons.check : Icons.more_horiz_outlined,
                    color: remainingSets == 0 ? Colors.grey : Color(0xFF0dbab4),
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
