import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBXWcnXjHZZh_mOf-ecwAne3lMwFqihMS8',
      appId: '1:737437055403:android:dac3a4f9d5a141cf26baee',
      messagingSenderId: '737437055403',
      projectId: 'fitscoop-eac87',
      storageBucket: 'fitscoop-eac87.appspot.com',
    ),
  );
  runApp(MyApp());
  await fetchAndSaveExercises();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Exercise App')),
        body: Center(child: Text('Welcome to Exercise App')),
      ),
    );
  }
}

Future<void> fetchAndSaveExercises() async {
  final url = Uri.https('exercisedb.p.rapidapi.com', '/exercises', {
    'limit': '0',
    'offset': '0'
  });

  final headers = {
    'x-rapidapi-key': 'de891019abmshbe42d611de150dep145f3djsn244c8e29a5b1', // Replace with your actual API key
    'x-rapidapi-host': 'exercisedb.p.rapidapi.com'
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      await saveExercisesToFirestore(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
Future<void> fetchAndSaveMuscles() async{
  final url = Uri.https('exercisedb.p.rapidapi.com', '/exercises/bodyPartList', {
    'limit': '0',
    'offset': '0'
  });

  final headers = {
    'x-rapidapi-key': 'de891019abmshbe42d611de150dep145f3djsn244c8e29a5b1', // Replace with your actual API key
    'x-rapidapi-host': 'exercisedb.p.rapidapi.com'
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      await saveMusclesToFirestore(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }

}

Future<void> fetchAndSaveEquipmentList() async {
  final url = Uri.https('exercisedb.p.rapidapi.com', 'exercises/equipmentList');

  final headers = {
    'x-rapidapi-key': 'de891019abmshbe42d611de150dep145f3djsn244c8e29a5b1', // Replace with your actual API key
    'x-rapidapi-host': 'exercisedb.p.rapidapi.com'
  };

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      await saveEquipmentListToFirestore(data);
    } else {
      print('Request failed with status: ${response.statusCode}.');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
Future<void> saveEquipmentListToFirestore(List<dynamic> equipmentList) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference equipmentCollection = firestore.collection('equipments');

  for (var equipment in equipmentList) {
    print(equipmentList.length);
    String docId = equipment.toString(); // Use the equipment name as the document ID
    await equipmentCollection.doc(docId).set({'name': equipment});
  }
}

Future<void> saveExercisesToFirestore(List exercises) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference exercisesCollection = firestore.collection('exercises');

  for (var exercise in exercises) {
    String docId = exercise['id'].toString();
    await exercisesCollection.doc(docId).set(exercise);
  }
}
Future <void> saveMusclesToFirestore(List muscles) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference musclesCollection = firestore.collection('bodyparts');
  int count  = 0 ;
  for (var bodyPart in muscles) {
    String docId = bodyPart.toString(); // Use the body part name as the document ID
    await musclesCollection.doc(docId).set({'name': bodyPart});
  }
}
Future<int> getCollectionCount(String collectionName) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await firestore.collection(collectionName).get();
  return querySnapshot.docs.length;
}



