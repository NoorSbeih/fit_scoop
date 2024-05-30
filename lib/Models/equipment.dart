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
    return Equipment(
        id: map['id'],
        name: map['name'],
        type1: map['type1'],
        type2: map['type2'],
       imageUrl: map['imageUrl'],
    );
  }


}
