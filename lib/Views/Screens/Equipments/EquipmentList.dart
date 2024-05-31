import 'package:flutter/material.dart';
import '../../../Models/equipment.dart';
import '../../../Models/user_singleton.dart';

class EquipmentList extends StatefulWidget {
  final List<Equipment> equipment;
  final ValueChanged<List<String>> onSelectionChanged;
  final List<String> selectedEquipmentIdsByTab;

  EquipmentList({required this.equipment, required this.onSelectionChanged, required this.selectedEquipmentIdsByTab});

  @override
  _EquipmentListState createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  late List<int> selectedIdxs;
  late List<bool> isSelected;

  @override
  void initState() {
    super.initState();
    // Initialize selectedIdxs and isSelected based on the length of the equipment list
    selectedIdxs = List.filled(widget.equipment.length, -1);
    isSelected = List.generate(
      widget.equipment.length,
          (index) => widget.selectedEquipmentIdsByTab.contains(widget.equipment[index].id),
    );
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Equipment>> equipmentByType2 = {};
    for (var equipment in widget.equipment) {
      if (!equipmentByType2.containsKey(equipment.type2)) {
        equipmentByType2[equipment.type2] = [];
      }
      equipmentByType2[equipment.type2]!.add(equipment);
    }

    return ListView(
      children: equipmentByType2.keys.map((type2) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                type2,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(), // Prevent GridView from scrolling
              shrinkWrap: true, // Take only the necessary space
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of items per row
                mainAxisSpacing: 10.0, // Spacing between rows
                crossAxisSpacing: 1.0, // Spacing between columns
                childAspectRatio: 2.0, // Width to height ratio of grid items
              ),
              itemCount: equipmentByType2[type2]!.length,
              itemBuilder: (context, index) {
                final item = equipmentByType2[type2]![index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIdxs[widget.equipment.indexOf(item)] = selectedIdxs[widget.equipment.indexOf(item)] == -1 ? index : -1;
                      widget.onSelectionChanged(getSelectedIds());
                      isSelected[widget.equipment.indexOf(item)] = !isSelected[widget.equipment.indexOf(item)]; // Toggle isSelected
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      color: isSelected[widget.equipment.indexOf(item)] ? Colors.white : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 8.0,right:8), // Adjust padding if needed
                            child: Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 15,
                                color: isSelected[widget.equipment.indexOf(item)] ? Colors.blueGrey : Colors.white,
                              ),
                            ),
                          ),
                        ),
                        // Add some spacing between text and image
                        ClipRRect(// Adjust border radius if needed
                          child: Image.asset(
                            item.imageUrl,
                            width: 80, // Set a fixed width for the image
                            height: 80, // Set a fixed height for the image
                            fit: BoxFit.fill, // Make sure the image fits within the dimensions
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
      }).toList(),
    );
  }

  List<String> getSelectedIds() {
    List<String> selectedIds = [];
    for (int i = 0; i < selectedIdxs.length; i++) {
      if (selectedIdxs[i] == i) {
        selectedIds.add(widget.equipment[i].id);
      }
    }
    return selectedIds;
  }
}
