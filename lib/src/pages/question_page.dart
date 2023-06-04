import 'package:flutter/material.dart';

import '../models/UnitModel/unitoption_model.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key, required this.questions});
  final List<UnitQuestion> questions;
  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushNamed(context, 'questionWidget', arguments: widget.questions);
      },
      child: Text("Resolver los problemas propuestos"),
    );
  }
}
