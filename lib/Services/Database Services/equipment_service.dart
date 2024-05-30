// services/database_services/workout_service.dart


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_scoop/Models/equipment.dart';
import '../../Models/workout_model.dart';


class EquipmentService {
  final CollectionReference _equipmentsRef = FirebaseFirestore.instance.collection('equipment');



  Future<List<Equipment>> getAllEquipments() async {
    try {
      QuerySnapshot querySnapshot = await _equipmentsRef.get();
      List<Equipment> equipments = querySnapshot.docs.map((doc) {
        return Equipment.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      return equipments;
    } catch (e) {
      print('Error getting all equipments: $e');
      throw e;
    }
  }



}
