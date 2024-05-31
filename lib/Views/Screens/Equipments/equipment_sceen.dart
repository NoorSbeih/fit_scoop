import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:flutter/material.dart';
import '../../../Controllers/equipment_controller.dart';
import '../../../Models/equipment.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import 'EquipmentList.dart';

class EquipmentPage extends StatefulWidget {
  const EquipmentPage({Key? key}) : super(key: key);

  @override
  State<EquipmentPage> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String currentTabType;
  late Map<int, List<String>> selectedEquipmentIdsByTab;
  late User_model user;
  late List<Equipment> allEquipment = [];
  bool isLoading = true;
  UserController userController = UserController();
  UserSingleton userSingleton = UserSingleton.getInstance();


  late List<String> selectedEquipmentsForUser;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: equipmentTypes.length, vsync: this);
    currentTabType = 'Free Weights'; // Default tab type
    selectedEquipmentIdsByTab = {
      for (var index in List.generate(equipmentTypes.length, (index) => index)) index: []
    };

    fetchEquipments();
  }


  // Future<void> fetchEquipmentsForUser() async {
  //     UserSingleton userSingleton = UserSingleton.getInstance();
  //     User_model user = userSingleton.getUser();
  //     try {
  //       selectedEquipmentsForUser= await userController.getSavedEquipments(user.id);
  //       print(selectedEquipmentsForUser);
  //     } catch (e) {
  //       print('Error getting equipments: $e');
  //     }
  //
  //   }


  Future<void> fetchEquipmentsForUser() async {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();
    try {
      selectedEquipmentsForUser = await userController.getSavedEquipments(user.id);
      print(selectedEquipmentsForUser);

       setState(() {
         for (int i = 0; i < equipmentTypes.length; i++) {
           selectedEquipmentIdsByTab[i] = selectedEquipmentsForUser.where((id) => allEquipment.firstWhere((equipment) => equipment.id == id).type1 == equipmentTypes[i]).toList();
         }
       });
    } catch (e) {
      print('Error getting equipments: $e');
    }
  }

  Future<void> fetchEquipments() async {
    try {
      EquipmentController controller = EquipmentController();
      List<Equipment> equipments = await controller.getAllEquipments();
      setState(() {
        allEquipment = equipments;
        isLoading = false; // Data fetching complete
      });
      _tabController.addListener(() {
        setState(() {
          currentTabType = equipmentTypes[_tabController.index];
        });
      });
      fetchEquipmentsForUser();
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false; // Data fetching complete, even on error
      });
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
  void saveSelectedEquipment() {
    UserSingleton userSingleton = UserSingleton.getInstance();
    User_model user = userSingleton.getUser();
    List<String> allSelectedEquipmentIds = selectedEquipmentIdsByTab.values.expand((ids) => ids).toList();
    print('Selected Equipment IDs: $allSelectedEquipmentIds');
    try {
      // Remove deselected equipment from the database
      List<String> previouslySelectedEquipmentIds = selectedEquipmentsForUser;
      List<String> deselectedEquipmentIds = previouslySelectedEquipmentIds.where((id) => !allSelectedEquipmentIds.contains(id)).toList();
      userController.unsaveEquipments(user.id, deselectedEquipmentIds);

      // Save selected equipment to the database
      userController.saveEquipments(user.id, allSelectedEquipmentIds);
      print('Equipments saved successfully');
    } catch (e) {
      print('Error saving equipments: $e');
    }
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

        actions: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ElevatedButton(
              onPressed: saveSelectedEquipment,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFF0dbab4),
              ),
              child: Text('Save'),
            ),
          ),
        ],

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
