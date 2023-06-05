// To parse this JSON data, do
//
//     final unitBook = unitBookFromJson(jsonString);

import 'dart:convert';

import 'package:aritbook10/src/models/UnitModel/unitoption_model.dart';
import 'package:aritbook10/src/models/UnitModel/unitsubject._model.dart';
import 'package:aritbook10/src/models/UnitModel/unittopic_model.dart';

import 'unitquestion_model.dart';

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
  ///
  /// Preguntas
  ///

  List<Option> optionUnitOneQuestions1 = [
    Option(idOption: 1, answerOption: "openAngle", isTheCorrectOption: true),
    Option(idOption: 2, answerOption: "closedAngle", isTheCorrectOption: true),
    Option(idOption: 3, answerOption: "-2", isTheCorrectOption: true),
    Option(idOption: 4, answerOption: "6", isTheCorrectOption: true),
  ];
  List<Option> optionUnitOneQuestions2 = [
    Option(
        idOption: 1, answerOption: "..Respuesta 1", isTheCorrectOption: true),
    Option(
        idOption: 2, answerOption: "..Respuesta 2", isTheCorrectOption: false),
    Option(
        idOption: 3, answerOption: "..Respuesta 3", isTheCorrectOption: false),
    Option(
        idOption: 4, answerOption: "..Respuesta 4", isTheCorrectOption: false),
  ];
  List<Option> optionUnitOneQuestions3 = [
    Option(
        idOption: 1, answerOption: "...Respuesta 1", isTheCorrectOption: true),
    Option(
        idOption: 2, answerOption: "...Respuesta 2", isTheCorrectOption: false),
    Option(
        idOption: 3, answerOption: "...Respuesta 3", isTheCorrectOption: false),
    Option(
        idOption: 4, answerOption: "...Respuesta 4", isTheCorrectOption: false),
  ];
  List<Option> optionUnitOneQuestions4 = [
    Option(
        idOption: 1, answerOption: "....Respuesta 1", isTheCorrectOption: true),
    Option(
        idOption: 2,
        answerOption: "....Respuesta 2",
        isTheCorrectOption: false),
    Option(
        idOption: 3,
        answerOption: "....Respuesta 3",
        isTheCorrectOption: false),
    Option(
        idOption: 4,
        answerOption: "....Respuesta 4",
        isTheCorrectOption: false),
  ];

  List<UnitQuestion> unitOneQuestions = [
    UnitQuestion(
        idQuestion: 1,
        titleQuestion:
            "¿El par ordenado -2,6 en el cual -2 se encuenta abierto y el otro es 6 el cual esta cerrado? \n Grafique la recta",
        option: optionUnitOneQuestions1),
    UnitQuestion(
        idQuestion: 2,
        titleQuestion:
            "Si tengo 5 niños dentro del conjunto A y tengo 5 niñas dentro del conjunto B. \n ¿El siguiente diagrama representa la definición de función o relación?",
        option: optionUnitOneQuestions2),
    UnitQuestion(
        idQuestion: 3,
        titleQuestion: "Determine el producto cartesiano de: []",
        option: optionUnitOneQuestions3),
    UnitQuestion(
        idQuestion: 4,
        titleQuestion: "Evaluar la siguiente ecuación: []",
        option: optionUnitOneQuestions4),
  ];

  ///
  /// Preguntas
  ///

  List<Topic> subjectUnit1Subject1 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
    Topic(
        idTopic: 2,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG2_qoejet.png",
        urlVideoTopic: ""),
  ];

  List<Topic> subjectUnit1Subject2 = [
    Topic(
        idTopic: 3,
        tittleTopic: "Diagramas de VENN",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example2IMG1_fy5mtd.png",
        urlVideoTopic: ""),
    Topic(
        idTopic: 4,
        tittleTopic: "Diagramas de VENN",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example2IMG2_ev98lg.png",
        urlVideoTopic: "")
  ];

  List<Topic> subjectUnit1Subject3 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
  ];

  List<Topic> subjectUnit1Subject4 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
  ];
  //Ejemplos
  List<Topic> subjectUnit1Subject5 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
  ];

  List<Topic> subjectUnit1Subject6 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
  ];

  List<Topic> subjectUnit1Subject7 = [
    Topic(
        idTopic: 1,
        tittleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
  ];
  List<UnitSubject> unitSubject1 = [
    UnitSubject(
        idSubject: 1,
        titleSubject: "Introducción",
        descriptionSubject:
            "Este relato describe cómo tu energía fluctúa a lo largo del día: despiertas lleno de energía tras dormir 8 horas, pero a medida que avanza el día y realizas tus actividades, como asistir al colegio, tu energía disminuye, llegando cansado al final del día.",
        topic: subjectUnit1Subject1),
    UnitSubject(
        idSubject: 2,
        titleSubject: "Diagramas de VENN",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject2),
    UnitSubject(
        idSubject: 3,
        titleSubject: "Dominio y Codominio o Rango",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject3),
    UnitSubject(
        idSubject: 4,
        titleSubject: "Producto Cartesiano",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject4),
    UnitSubject(
        idSubject: 5,
        titleSubject: "Formas de Representar",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject5),
    UnitSubject(
        idSubject: 6,
        titleSubject: "Relación",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject6),
    UnitSubject(
        idSubject: 7,
        titleSubject: "Función",
        descriptionSubject:
            "Esta fluctuación diaria de energía es un ejemplo práctico de una función, la cual puede ser explicada mediante una gráfica.",
        topic: subjectUnit1Subject7),
  ];

  return UnitBook(
      idUnitBook: "unidad_1",
      titleUnitBook: "Análisis Algebraico y Gráfico de Funciones",
      urlMainImage:
          "https://4.bp.blogspot.com/-_iS2aIwixHg/WYJ23N3nElI/AAAAAAAABFw/EtIzL5wqd3UFWsPawlCGVpodD-Q1Ol1cACEwYBhgL/s1600/unidad1.png",
      descriptionUnitBook:
          "Definir y reconocer funciones de manera algebraica y de manera gráfica, con diagramas de Venn, determinando su dominio y recorrido en Z.",

      //Agregar Informacion
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
          "Definir y reconocer funciones de manera algebraica y de manera gráfica, con diagramas de Venn, determinando su dominio y recorrido en Z.",
      unitSubject: unitSubject1,
      unitQuestion: unitOneQuestions);
}
