// To parse this JSON data, do
//
//     final unitBook = unitBookFromJson(jsonString);

import 'dart:convert';

import 'package:aritbook10/src/models/UnitModel/unitoption_model.dart';
import 'package:aritbook10/src/models/UnitModel/unitsubject._model.dart';
import 'package:aritbook10/src/models/UnitModel/unittopic_model.dart';

List<UnitBook> unitBookFromJson(String str) =>
    List<UnitBook>.from(json.decode(str).map((x) => UnitBook.fromJson(x)));

String unitBookToJson(List<UnitBook> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnitBook {
  String idUnitBook;
  String titleUnitBook;
  String urlMainImage;
  String descriptionUnitBook;
  List<UnitSubject> unitSubject;
  List<UnitQuestion> unitQuestion;

  UnitBook({
    required this.idUnitBook,
    required this.titleUnitBook,
    required this.urlMainImage,
    required this.descriptionUnitBook,
    required this.unitSubject,
    required this.unitQuestion,
  });

  factory UnitBook.fromJson(Map<String, dynamic> json) => UnitBook(
        idUnitBook: json["idUnitBook"],
        titleUnitBook: json["titleUnitBook"],
        urlMainImage: json["urlMainImage"],
        descriptionUnitBook: json["descriptionUnitBook"],
        unitSubject: List<UnitSubject>.from(
            json["unitSubject"].map((x) => UnitSubject.fromJson(x))),
        unitQuestion: List<UnitQuestion>.from(
            json["unitQuestion"].map((x) => UnitQuestion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idUnitBook": idUnitBook,
        "titleUnitBook": titleUnitBook,
        "urlMainImage": urlMainImage,
        "descriptionUnitBook": descriptionUnitBook,
        "unitSubject": List<dynamic>.from(unitSubject.map((x) => x.toJson())),
        "unitQuestion": List<dynamic>.from(unitQuestion.map((x) => x.toJson())),
      };
}

UnitBook unit1Example() {
  List<UnitQuestion> unitOneQuestions = [];

  List<Topic> subjectUnit1Subject1 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic: "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
          Topic(
        idTopic: 2,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example2IMG1_fy5mtd.png",
        urlVideoTopic: "")
  ];
  List<UnitSubject> unitSubject1 = [
    UnitSubject(
        idSubject: 1,
        titleSubject: "Ejemplo 1",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject1)
  ];
  return UnitBook(
      idUnitBook: "unidad_1",
      titleUnitBook:
          "Análisis Algebraico y Gráfico de Funciones",
      urlMainImage:
          "https://4.bp.blogspot.com/-_iS2aIwixHg/WYJ23N3nElI/AAAAAAAABFw/EtIzL5wqd3UFWsPawlCGVpodD-Q1Ol1cACEwYBhgL/s1600/unidad1.png",
      descriptionUnitBook:
          "Este relato describe cómo tu energía fluctúa a lo largo del día: despiertas lleno de energía tras dormir 8 horas, pero a medida que avanza el día y realizas tus actividades, como asistir al colegio, tu energía disminuye, llegando cansado al final del día.",
      unitSubject: unitSubject1,
      unitQuestion: unitOneQuestions);
}

UnitBook unit2Example() {
  List<UnitQuestion> unitOneQuestions = [];

  List<Topic> subjectUnit1Subject1 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic: "",
        urlVideoTopic: "")
  ];
  List<UnitSubject> unitSubject1 = [
    UnitSubject(
        idSubject: 1,
        titleSubject: "Ejemplo 1",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject1)
  ];
  return UnitBook(
      idUnitBook: "unidad_2",
      titleUnitBook:
          "Análisis Algebraico y Gráfico de Funciones: Dominio, Recorrido y Representación con Diagramas de Venn en Z",
      urlMainImage:
          "https://4.bp.blogspot.com/-8E1gYATAoOQ/WYJ23QBHbFI/AAAAAAAABFw/opP-0DTujBADYBMWkOG9AewVsADE64AzgCPcBGAYYCw/s1600/unidad2.png",
      descriptionUnitBook:
          "Este relato describe cómo tu energía fluctúa a lo largo del día: despiertas lleno de energía tras dormir 8 horas, pero a medida que avanza el día y realizas tus actividades, como asistir al colegio, tu energía disminuye, llegando cansado al final del día.",
      unitSubject: unitSubject1,
      unitQuestion: unitOneQuestions);
}
