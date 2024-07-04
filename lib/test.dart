import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  final url = Uri.https('exercisedb.p.rapidapi.com', '/exercises/target/abductors', {
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
      //print(data);
    } else {
      //print('Request failed with status: ${response.statusCode}.');
      //print('Response body: ${response.body}');
    }
  } catch (error) {
    //print('Error: $error');
  }
}


