import 'package:fit_scoop/Controllers/user_controller.dart';
import 'package:flutter/material.dart';
import '../../../Controllers/equipment_controller.dart';
import '../../../Models/equipment.dart';
import '../../../Models/user_model.dart';
import '../../../Models/user_singleton.dart';
import '../Equipments/EquipmentList.dart';
import 'package:fit_scoop/Views/Widgets/custom_widget.dart';

class RegisterPage6 extends StatefulWidget {
  static List<String> selectedEquipments = [];
  final Function(List<String>) onEquipmentSelected;
  RegisterPage6({Key? key, required this.onEquipmentSelected}) : super(key: key);

  @override
  State<RegisterPage6> createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<RegisterPage6> with SingleTickerProviderStateMixin {
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

    _tabController.addListener(() {
      setState(() {
        currentTabType = equipmentTypes[_tabController.index];
      });
    });
  }

  Future<void> loadSelectedEquipments() async {
    if (RegisterPage6.selectedEquipments.isNotEmpty) {
      setState(() {
        for (int i = 0; i < equipmentTypes.length; i++) {
          selectedEquipmentIdsByTab[i] = RegisterPage6.selectedEquipments.where((id) => allEquipment.firstWhere((equipment) => equipment.name == id).type1 == equipmentTypes[i]).toList();
        }
      });
    }
  }

  void saveSelectedEquipment() {
    List<String> allSelectedEquipmentIds = selectedEquipmentIdsByTab.values.expand((ids) => ids).toList();
    widget.onEquipmentSelected(allSelectedEquipmentIds);
    RegisterPage6.selectedEquipments = allSelectedEquipmentIds;
  }

  Future<void> fetchEquipments() async {
    try {
      EquipmentController controller = EquipmentController();
      List<Equipment> equipments = await controller.getAllEquipments();
      setState(() {
        allEquipment = equipments;
        isLoading = false; // Data fetching complete
      });
      await loadSelectedEquipments(); // Load selected equipments after fetching
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false; // Data fetching complete, even on error
      });
    }
  }

  final List<String> equipmentTypes = [
    'Free Weights',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 16, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.startTextWidget("Available Equipments"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, left: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: custom_widget.customTextWidget("Please choose the available equipments", 15),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              dividerColor: const Color(0xFF2C2A2A),
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              indicatorColor: const Color(0xFF0dbab4),
              isScrollable: false,
              padding: EdgeInsets.zero,
              tabs: equipmentTypes.map((type) => Tab(text: type)).toList(),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : TabBarView(
              controller: _tabController,
              children: equipmentTypes.map((type) {
                return Column(
                  children: [
                    Expanded(
                      child: EquipmentList(
                        equipment: allEquipment.where((equipment) => equipment.type1 == type).toList(),
                        onSelectionChanged: (selectedEquipmentIds) {
                          setState(() {
                            selectedEquipmentIdsByTab[_tabController.index] = selectedEquipmentIds;
                            saveSelectedEquipment();
                          });
                        },
                        selectedEquipmentIdsByTab: selectedEquipmentIdsByTab[_tabController.index] ?? [],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
