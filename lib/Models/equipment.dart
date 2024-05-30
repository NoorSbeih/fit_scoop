import 'body_metrics_model.dart';


class Equipment {
  String id;
  String name;
  String type;
  String imageUrl;

  Equipment({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type
    };
  }
  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
        id: map['id'],
        name: map['name'],
        type: map['type'],
       imageUrl: map['imageUrl'],
    );
  }


}
