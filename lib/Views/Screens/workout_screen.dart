import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Models/user_model.dart';
import '../../Models/user_singleton.dart';
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
  void initState() {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();
    String  userId = user.id; // Assuming you want the user's UID
    print(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2C2A2A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}