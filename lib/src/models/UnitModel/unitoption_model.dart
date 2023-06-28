import 'package:aritbook10/src/models/UnitModel/unitquestion_model.dart';

class UnitQuestion {
  String idQuestion;
  String titleQuestion;
  String feedBackQuestion;
  String urlImageOrVideoQuestion;
  List<Option> option;

  UnitQuestion({
    required this.idQuestion,
    required this.titleQuestion,
    required this.feedBackQuestion,
    required this.urlImageOrVideoQuestion,
    required this.option,
  });

  factory UnitQuestion.fromJson(Map<String, dynamic> json) => UnitQuestion(
        idQuestion: json["idQuestion"],
        titleQuestion: json["titleQuestion"],
        feedBackQuestion: json["feedBackQuestion"],
        urlImageOrVideoQuestion: json["urlImageOrVideoQuestion"],
        option:
            List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idQuestion": idQuestion,
        "titleQuestion": titleQuestion,
        "feedBackQuestion": feedBackQuestion,
        "urlImageOrVideoQuestion": urlImageOrVideoQuestion,
        "option": List<dynamic>.from(option.map((x) => x.toJson())),
      };
}
