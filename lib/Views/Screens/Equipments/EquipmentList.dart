import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Models/equipment.dart';

class EquipmentList extends StatefulWidget {
  final List<Equipment> equipment;
  final ValueChanged<List<String>> onSelectionChanged;

  EquipmentList({required this.equipment, required this.onSelectionChanged});

  @override
  _EquipmentListState createState() => _EquipmentListState();
}

class _EquipmentListState extends State<EquipmentList> {
  late List<int> selectedIdxs;

  @override
  void initState() {
    super.initState();
    selectedIdxs = List.filled(widget.equipment.length, -1);

    print(selectedIdxs.first.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.equipment.length,
      itemBuilder: (context, index) {
        final item = widget.equipment[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIdxs[index] = selectedIdxs[index] == -1 ? index : -1;
              widget.onSelectionChanged(getSelectedIds());
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: selectedIdxs[index] == index ? Colors.white : Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: selectedIdxs[index] == index ? Colors.blueGrey : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Add some spacing between text and image
                  Image.asset(
                    item.imageUrl,
                    width: 50, // Set a fixed width for the image
                    height: 50, // Set a fixed height for the image
                    fit: BoxFit.cover, // Make sure the image fits within the dimensions
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
