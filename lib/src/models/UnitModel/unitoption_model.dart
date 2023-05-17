import 'package:aritbook10/src/models/UnitModel/unitquestion_model.dart';

class UnitQuestion {
  int idQuestion;
  String titleQuestion;
  List<Option> option;

  UnitQuestion({
    required this.idQuestion,
    required this.titleQuestion,
    required this.option,
  });

  factory UnitQuestion.fromJson(Map<String, dynamic> json) => UnitQuestion(
        idQuestion: json["idQuestion"],
        titleQuestion: json["titleQuestion"],
        option:
            List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idQuestion": idQuestion,
        "titleQuestion": titleQuestion,
        "option": List<dynamic>.from(option.map((x) => x.toJson())),
      };
}
