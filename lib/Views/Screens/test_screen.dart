import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';
class Test extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home: TestPage(),
    );
  }
}


class TestPage extends StatefulWidget {

  const TestPage({Key? key}) : super(key: key);
  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      backgroundColor: Color(0xFF2C2A2A),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
      Padding(
      padding: EdgeInsets.only(top:10,left:16,bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: custom_widget.startTextWidget("Test"),
      ),

    ),

          ],
      ),
    );

  }
}