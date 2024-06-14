import 'body_metrics_model.dart';


class BodyPart {
  String name;

  String imageUrl;

  BodyPart({

    required this.name,
    required this.imageUrl
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl':imageUrl
    };
  }
  factory BodyPart.fromMap(Map<String, dynamic> map) {
    final name = map['name'];
    final imageUrl = map['imageUrl'];
    return BodyPart(
      name: name ?? '',

      imageUrl: imageUrl ?? '',
    );
  }


}
