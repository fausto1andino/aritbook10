import 'unittopic_model.dart';

class UnitSubject {
  int idSubject;
  String titleSubject;
  String descriptionSubject;
  List<Topic> topic;

  UnitSubject({
    required this.idSubject,
    required this.titleSubject,
    required this.descriptionSubject,
    required this.topic,
  });

  factory UnitSubject.fromJson(Map<String, dynamic> json) => UnitSubject(
        idSubject: json["idSubject"],
        titleSubject: json["titleSubject"],
        descriptionSubject: json["descriptionSubject"],
        topic: List<Topic>.from(json["topic"].map((x) => Topic.fromJson(x))),
      );

  String? get id => null;

  Map<String, dynamic> toJson() => {
        "idSubject": idSubject,
        "titleSubject": titleSubject,
        "descriptionSubject": descriptionSubject,
        "topic": List<dynamic>.from(topic.map((x) => x.toJson())),
      };
}
