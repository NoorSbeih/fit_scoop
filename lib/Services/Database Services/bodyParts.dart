

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_scoop/Models/bodyPart.dart';
class BodyPartService {
  final CollectionReference _exercisesRef = FirebaseFirestore.instance.collection('targetMuscles');

  // Retrieve exercise document from Firestore based on exercise name
  Future<String?> getImage(String name) async {
    try {
      var querySnapshot = await _exercisesRef.where('name', isEqualTo: name).get();
      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        var data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('imageUrl')) {
          print(data['imageUrl'] as String);
          return data['imageUrl'] as String;

        }
      }
      return null; // Image URL not found
    } catch (e) {
      print('Error getting imageUrl: $e');
      throw e;
    }
  }

  Future<List<BodyPart>> getAllImages() async {
    try {
      print("hshshshsh");
      QuerySnapshot querySnapshot = await _exercisesRef.get();
      List<BodyPart> equipments = querySnapshot.docs.map((doc) {
        return BodyPart.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
      print(equipments);
      return equipments;
    } catch (e) {
      print('Error getting all bodyParts: $e');
      throw e;
    }
  }

}
