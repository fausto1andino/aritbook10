class Option {
  int idOption;
  String answerOption;
  bool isTheCorrectOption;

  Option({
    required this.idOption,
    required this.answerOption,
    required this.isTheCorrectOption,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        idOption: json["idOption"],
        answerOption: json["answerOption"],
        isTheCorrectOption: json["isTheCorrectOption"],
      );

  Map<String, dynamic> toJson() => {
        "idOption": idOption,
        "answerOption": answerOption,
        "isTheCorrectOption": isTheCorrectOption,
      };
}
