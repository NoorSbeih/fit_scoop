import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:fit_scoop/Models/user_model.dart';
import 'package:fit_scoop/Models/user_singleton.dart';
import 'package:fit_scoop/Views/Widgets/workout_widget.dart';
import 'package:flutter/material.dart';

import '../../../Controllers/workout_controller.dart';
import '../../../Models/equipment.dart';
import '../../../Models/workout_model.dart';
import '../../Widgets/drawer_widget.dart';
import 'EquipmentList.dart';


class EquipmentPage extends StatefulWidget {
  const EquipmentPage({Key? key}) : super(key: key);

  @override
  State<EquipmentPage> createState() => _EquipmentScreen();
}

class _EquipmentScreen extends State<EquipmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<List<String>> selectedEquipmentIdsByTab;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length:4, vsync: this);
    selectedEquipmentIdsByTab = List.generate(4, (index) => []);
  }

  final List<String> equipmentTypes = ['Free Weights', 'Benches, Bars, and Racks', 'Machines','Bands and more'];
  final List<Equipment> allEquipment = [
    Equipment(name: 'Common Mini ', type1: 'Free Weights',type2:'fjjf', imageUrl: 'images/barbells.png', id: '1'),
    Equipment(name: 'Equipment2', type1: 'Benches, Bars, and Racks',type2:'fjfj', imageUrl: 'images/google.jpg', id: '2'),
    // Add more equipment here
  ];


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: const Color(0xFF2C2A2A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF2C2A2A),
          title: const Text(
            'Available Equipment',
            style: TextStyle(
              fontSize: 20, // Adjust the font size as needed
              color: Colors.white, // Adjust the color as needed
            ),
          ),
          iconTheme: const IconThemeData(
            color: Color(0xFF0dbab4), // Change the drawer icon color here
          ),
          // bottom: TabBar(
          //   isScrollable: true,
          //   controller: _tabController,
          //   labelColor: Colors.white,
          //   dividerColor: Color(0xFF2C2A2A),
          //   labelStyle: TextStyle(fontWeight: FontWeight.bold),
          //   indicatorColor: Color(0xFF0dbab4),
          //   tabs: const [
          //     Tab(text: 'Free Weights'),
          //     Tab(text: 'Benches, Bars, and Racks'),
          //     Tab(text: 'Machines'),
          //     Tab(text: 'Bands and more'),
          //   ],
          // ),

          bottom: TabBar(
            labelColor: Colors.white,
            dividerColor: const Color(0xFF2C2A2A),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicatorColor: const Color(0xFF0dbab4),
            isScrollable: true,
            tabs: equipmentTypes.map((type) => Tab(text: type)).toList(),
            onTap: (index) {
              // Save selected equipment for the current tab
              print('Selected Equipment for tab $index: ${selectedEquipmentIdsByTab[index]}');
            },
          ),
        ),
        body: TabBarView(
          children: equipmentTypes.map((type) {
            return EquipmentList(
              equipment: allEquipment.where((e) => e.type1 == type).toList(),
              onSelectionChanged: (selectedIds) {
                setState(() {
                  selectedEquipmentIdsByTab[equipmentTypes.indexOf(type)] = selectedIds;
                });
              },
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Handle the selection of equipment items
            print('Selected Equipment IDs by Tab: $selectedEquipmentIdsByTab');
          },
          child: const Icon(Icons.check),
        ),
      ),
      );
  }
}