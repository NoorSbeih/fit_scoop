//create am empty screen for now

import 'package:flutter/material.dart';
import '../main_page_screen.dart';


class  CommunityPage extends StatefulWidget {

  @override
  _communityPage createState() => _communityPage();
}

class _communityPage  extends State< CommunityPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color(0xFF2C2A2A),
     appBar: AppBar(
   backgroundColor: Color(0xFF2C2A2A),
    leading: IconButton(
    icon: const Icon(Icons.menu, color: Color(0xFF0dbab4)),
    onPressed: () {
    },
    )
     )
    );
  }
}