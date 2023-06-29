import 'package:flutter/material.dart';

import '../../models/UnitModel/unit_model.dart';

class TopicDetail extends StatelessWidget {
  final UnitBook unitBook;

  const TopicDetail(this.unitBook, {super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.1, vertical: size.height * 0.025),
      /*child: Text(
        unitBook.unitSubject.first.topic.first.titleTopic,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleLarge,
      ),*/
    );
  }
}
