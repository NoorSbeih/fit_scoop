import 'package:fit_scoop/Controllers/equipment_controller.dart';
import 'package:flutter/material.dart';

import '../../../Models/equipment.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import 'EquipmentList.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({Key? key}) : super(key: key);

  @override
  State<EquipmentPage> createState() => _EquipmentScreenState();
}

class _EquipmentScreenState extends State<EquipmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String currentTabType;
  late List<List<bool>> isSelectedByTab;
  late Map<int, List<String>> selectedEquipmentIdsByTab;
  late User_model user;
  late List<Equipment> allEquipment=[];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
   fetchEquipments();
    isSelectedByTab =
        List.generate(4, (index) => List.filled(allEquipment.length, false));
    selectedEquipmentIdsByTab = {
      for (var index in List.generate(4, (index) => index)) index: []
    };
    currentTabType = 'Free Weights'; // Default tab type
    _tabController.addListener(() {
      setState(() {
        currentTabType = equipmentTypes[_tabController.index];
      });
    });
  }


  Future<void> fetchEquipments() async {
    try {
      EquipmentController controller = EquipmentController();
      List<Equipment> equipments = await controller.getAllEquipments();
      setState(() {
        allEquipment = equipments;
        isSelectedByTab =
            List.generate(4, (index) => List.filled(allEquipment.length, false));
      });
    } catch (e) {
      print('Error fetching data: $e');
      // Handle error if needed
    }
  }

  void fetchData() async {
    try {
      UserSingleton userSingleton = UserSingleton.getInstance();
      user = userSingleton.getUser();

    } catch (e) {
      print('Error fetching data: $e');
      // Handle error if needed
    }
  }


  final List<String> equipmentTypes = [
    'Free Weights',
    'Benches, Bars, and Racks',
    'Machines',
    'Bands and more'
  ];

  // final List<Equipment> allEquipment = [
  //   Equipment(
  //       name: 'Common Mini ',
  //       type1: 'Free Weights',
  //       type2: 'djdjd',
  //       imageUrl: 'images/google.jpg',
  //       id: '1'),
  //   Equipment(
  //       name: 'Equipment2',
  //       type1: 'Benches, Bars, and Racks',
  //       type2: 's',
  //       imageUrl: 'images/google.jpg',
  //       id: '2'),
  //   Equipment(
  //       name: 'Equipment6',
  //       type1: 'Benches, Bars, and Racks',
  //       type2: 's',
  //       imageUrl: 'images/google.jpg',
  //       id: '6'),
  //   Equipment(
  //       name: 'Equipment3',
  //       type1: 'Benches, Bars, and Racks',
  //       type2: 'x',
  //       imageUrl: 'images/google.jpg',
  //       id: '3'),
  //   // Add more equipment here
  // ];

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            alignment: Alignment.centerLeft, // Aligns the TabBar to the left
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              dividerColor: const Color(0xFF2C2A2A),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              indicatorColor: const Color(0xFF0dbab4),
              isScrollable: true,
              padding: EdgeInsets.zero,
              tabs: equipmentTypes.map((type) => Tab(text: type)).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: equipmentTypes.map((type) {
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                // Align the text to the left
                margin: EdgeInsets.fromLTRB(10, 15.0, 20.0, 0.0),
                // Adjust margins if needed
                child: Text(
                  '$type',
                  style: const TextStyle(
                    fontSize: 20, // Adjust the font size as needed
                    color: Colors.white, // Adjust the color as needed
                  ),
                ),
              ),
              Expanded(
                child: EquipmentList(
                  equipment: allEquipment
                      .where((e) => e.type1 == type || e.type2 == type)
                      .toList(),
                  onSelectionChanged: (selectedIds) {
                    setState(() {
                      selectedEquipmentIdsByTab[equipmentTypes.indexOf(type)] =
                          selectedIds;
                    });
                  },
                  selectedEquipmentIdsByTab:
                      selectedEquipmentIdsByTab[equipmentTypes.indexOf(type)]!,
                ),
              ),
            ],
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
    );
  }
}
