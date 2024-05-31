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
  Map<int, List<String>> selectedEquipmentIdsByTab = {};
  late User_model user;
  late List<Equipment> allEquipment = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: equipmentTypes.length, vsync: this);
    currentTabType = 'Free Weights'; // Default tab type
    fetchEquipments();
  }

  Future<void> fetchEquipments() async {
    try {
      EquipmentController controller = EquipmentController();
      List<Equipment> equipments = await controller.getAllEquipments();
      setState(() {
        allEquipment = equipments;
        isSelectedByTab = List.generate(4, (index) => List.filled(allEquipment.length, false));
        selectedEquipmentIdsByTab = {
          for (var index in List.generate(equipmentTypes.length, (index) => index)) index: []
        };
        isLoading = false; // Data fetching complete
      });
      _tabController.addListener(() {
        setState(() {
          currentTabType = equipmentTypes[_tabController.index];
        });
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false; // Data fetching complete, even on error
      });
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
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFF0dbab4),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: equipmentTypes.map((type) {
          return Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(10, 15.0, 20.0, 0.0),
                child: Text(
                  '$type',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: EquipmentList(
                  equipment: allEquipment.where((equipment) => equipment.type1 == type).toList(),
                  onSelectionChanged: (selectedEquipmentIds) {
                    setState(() {
                      selectedEquipmentIdsByTab[_tabController.index] = selectedEquipmentIds;
                    });
                  },
                  selectedEquipmentIdsByTab: selectedEquipmentIdsByTab[_tabController.index] ?? [],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
