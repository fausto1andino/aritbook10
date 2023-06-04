import 'package:flutter/material.dart';

import '../../models/UnitModel/unitsubject._model.dart';

class TopicExample extends StatelessWidget {
  final UnitSubject unitBookSubject;

  const TopicExample(this.unitBookSubject, {super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Text(
            unitBookSubject.titleSubject,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Text(
                unitBookSubject.descriptionSubject,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
        SizedBox(
          height: size.height * 0.9,
          width: size.width * 0.9,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/images/no-image.jpg'),
                        image: NetworkImage(
                            unitBookSubject.topic[index].urlImageTopic),
                        height: size.height * 0.3,
                      ),
                    );
                  },
                  childCount: unitBookSubject.topic.length,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
