import 'body_metrics_model.dart';


class Equipment {
  String id;
  String name;
  String type1;
  String type2;
  String imageUrl;

  Equipment({
    required this.id,
    required this.name,
    required this.type1,
    required this.type2,
    required this.imageUrl
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type1':type1,
      'type2': type2,
      'imageUrl':imageUrl
    };
  }
  factory Equipment.fromMap(Map<String, dynamic> map) {
    final id = map['id'];
    final name = map['name'];
    final type1 = map['type1'];
    final type2 = map['type2'];
    final imageUrl = map['imageUrl'];

    if (id == null) print('Error: id is null');
    if (name == null) print('Error: name is null');
    if (type1 == null) print('Error: type1 is null');
    if (type2 == null) print('Error: type2 is null');
    if (imageUrl == null) print('Error: imageUrl is null');

    return Equipment(
      id: id ?? '',
      name: name ?? '',
      type1: type1 ?? '',
      type2: type2 ?? '',
      imageUrl: imageUrl ?? '',
    );
  }


}
