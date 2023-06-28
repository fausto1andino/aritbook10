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
    Option(idOption: 3, answerOption: "7", isTheCorrectOption: true),
    Option(idOption: 4, answerOption: "10", isTheCorrectOption: true),
  ];
  List<Option> optionUnitOneQuestions2 = [
    Option(idOption: 1, answerOption: "openAngle", isTheCorrectOption: true),
    Option(idOption: 2, answerOption: "closedAngle", isTheCorrectOption: true),
    Option(idOption: 3, answerOption: "-3", isTheCorrectOption: true),
    Option(idOption: 4, answerOption: "7", isTheCorrectOption: true),
  ];
  List<Option> optionUnitOneQuestions3 = [
    Option(idOption: 1, answerOption: "(-5, 8)", isTheCorrectOption: true),
    Option(idOption: 2, answerOption: "(-1, 4)", isTheCorrectOption: true),
    Option(idOption: 3, answerOption: "-1", isTheCorrectOption: true),
    Option(idOption: 4, answerOption: "-x+13", isTheCorrectOption: true),
  ];

  List<Option> optionUnitOneQuestions4 = [
    Option(idOption: 1, answerOption: "3", isTheCorrectOption: true),
    Option(idOption: 2, answerOption: "2,3,5", isTheCorrectOption: true),
    Option(idOption: 3, answerOption: "5,7,11", isTheCorrectOption: true),
    Option(idOption: 4, answerOption: "R", isTheCorrectOption: true),
  ];
  List<Option> optionUnitOneQuestions5 = [
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
        idQuestion: "1",
        titleQuestion: "Grafique el siguiente intervalo: ",
        feedBackQuestion: "",
        urlImageOrVideoQuestion: "",
        option: optionUnitOneQuestions1),
    UnitQuestion(
        idQuestion: "2",
        titleQuestion: "Grafique el siguiente intervalo:  ",
        feedBackQuestion: "",
        urlImageOrVideoQuestion: "",
        option: optionUnitOneQuestions2),
    UnitQuestion(
        idQuestion: "3",
        titleQuestion:
            "Grafique y Estime el valor de la pendiente m de los puntos P1 (-5, 8) y P2  P2 (-1, 4), adicionalmente formule la ecuación de la recta de P1 ",
        feedBackQuestion: "",
        urlImageOrVideoQuestion: "",
        option: optionUnitOneQuestions3),
    UnitQuestion(
        idQuestion: "3",
        titleQuestion:
            "Dada la siguiente relacion en el conjunto A y B encontrar los valores que se asocien",
        feedBackQuestion: "",
        urlImageOrVideoQuestion: "",
        option: optionUnitOneQuestions4),
    UnitQuestion(
        idQuestion: "4",
        titleQuestion:
            "Dada la siguiente funcion determinar si es funcion o no, tambien determinar el domino y rango de la funcion",
        feedBackQuestion: "",
        urlImageOrVideoQuestion: "",
        option: optionUnitOneQuestions5),
  ];

  ///
  /// Preguntas
  ///

  List<Topic> subjectUnit1Subject1 = [
    Topic(
        idTopic: 1,
        titleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG1_rgcrno.png",
        urlVideoTopic: ""),
    Topic(
        idTopic: 2,
        titleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example1IMG2_qoejet.png",
        urlVideoTopic: ""),
  ];

  List<Topic> subjectUnit1Subject2 = [
    Topic(
        idTopic: 3,
        titleTopic: "Diagramas de VENN",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example2IMG1_fy5mtd.png",
        urlVideoTopic: ""),
    Topic(
        idTopic: 4,
        titleTopic: "Diagramas de VENN",
        topicDescription: "Jhonatan Laines",
        urlImageTopic:
            "https://res.cloudinary.com/dsuh0d4g5/image/upload/v1684299777/DocIDImage/example2IMG2_ev98lg.png",
        urlVideoTopic: "")
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
  ];

  return UnitBook(
      idUnitBook: "unidad_1",
      titleUnitBook: "Análisis Algebraico y Gráfico de Funciones",
      urlMainImage:
          "https://4.bp.blogspot.com/-_iS2aIwixHg/WYJ23N3nElI/AAAAAAAABFw/EtIzL5wqd3UFWsPawlCGVpodD-Q1Ol1cACEwYBhgL/s1600/unidad1.png",
      descriptionUnitBook:
          "Esta es una nueva plantilla acerca de Fisica cuantica.",

      //Agregar Informacion
      unitSubject: unitSubject1,
      unitQuestion: unitOneQuestions);
}

UnitBook unit2Example() {
  List<UnitQuestion> unitOneQuestions = [];

  List<Topic> subjectUnit1Subject1 = [
    Topic(
        idTopic: 1,
        titleTopic: "Ejemplo de energía en el día.",
        topicDescription: "Jhonatan Laines",
        urlImageTopic: "",
        urlVideoTopic: "")
  ];
  List<UnitSubject> unitSubject1 = [
    UnitSubject(
        idSubject: 1,
        titleSubject: "Ejemplo 1",
        descriptionSubject:
            "Esta es una nueva plantilla acerca de Fisica cuantica",
        topic: subjectUnit1Subject1)
  ];
  return UnitBook(
      idUnitBook: "unidad_2",
      titleUnitBook: "Esta es una nueva plantilla acerca de Fisica cuantica",
      urlMainImage:
          "https://4.bp.blogspot.com/-8E1gYATAoOQ/WYJ23QBHbFI/AAAAAAAABFw/opP-0DTujBADYBMWkOG9AewVsADE64AzgCPcBGAYYCw/s1600/unidad2.png",
      descriptionUnitBook:
          " Esta es una nueva plantilla acerca de Fisica cuantica",
      unitSubject: unitSubject1,
      unitQuestion: unitOneQuestions);
}
