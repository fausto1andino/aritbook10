import 'package:flutter/material.dart';

import '../models/UnitModel/unitoption_model.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.questions, required this.type});
  final String type;
  final List<UnitQuestion> questions;
  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (widget.type == "lesson") {
             Navigator.pushNamed(context, 'questionWidget',
              arguments: widget.questions);
        }else{
            Navigator.pushNamed(context, 'problemWidget',
              arguments: widget.questions);
        }
     
      },
      child: Text((widget.type == "lesson") ? "Resolver Leccion": "Resolver los problemas propuestos"),
    );
  }
}
