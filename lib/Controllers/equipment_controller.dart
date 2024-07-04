
import 'package:fit_scoop/Models/equipment.dart';
import 'package:fit_scoop/Services/Database%20Services/equipment_service.dart';

import '../Models/workout_model.dart';
import '../Services/Database Services/workout_service.dart';



class EquipmentController {
  final _equipmentService = EquipmentService();



  Future<List<Equipment>> getAllEquipments() async {
    try {
      return await _equipmentService.getAllEquipments();
    } catch (e) {
      //print('Error getting all equipments: $e');
      throw e;
    }
  }
}
