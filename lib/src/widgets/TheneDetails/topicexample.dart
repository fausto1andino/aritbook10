import 'dart:developer';

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
          padding: const EdgeInsets.only(left: 10, right: 35, bottom: 10),
          child: Text(
            unitBookSubject.titleSubject,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, right: 35, bottom: 10),
              child: Text(
                unitBookSubject.descriptionSubject,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        Column(
            //List of images of the topic
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: unitBookSubject.topic.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: InteractiveViewer(
                                boundaryMargin: EdgeInsets.all(0),
                                minScale: 0.1,
                                maxScale: 5.0,
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                      'assets/images/no-image.jpg'),
                                  image: unitBookSubject
                                              .topic[index].urlImageTopic !=
                                          ''
                                      ? NetworkImage(unitBookSubject
                                          .topic[index].urlImageTopic)
                                      : NetworkImage(
                                          'assets/images/LogoAritbook.png'),
                                  height: size.height * 0.3,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/images/no-image.jpg'),
                          image: unitBookSubject.topic[index].urlImageTopic !=
                                  ''
                              ? NetworkImage(
                                  unitBookSubject.topic[index].urlImageTopic)
                              : NetworkImage('assets/images/LogoAritbook.png'),
                          height: size.height * 0.3,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ]
            /* child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: SizedBox(
                                height: size.height * 0.5,
                                width: size.width * 0.9,
                                child: InteractiveViewer(
                                  boundaryMargin: EdgeInsets.all(0),
                                  minScale: 0.1,
                                  maxScale: 5.0,
                                  child: Image.network(
                                    unitBookSubject.topic[index].urlImageTopic,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage(
                            placeholder:
                                AssetImage('assets/images/no-image.jpg'),
                            image: NetworkImage(
                                unitBookSubject.topic[index].urlImageTopic),
                            height: size.height * 0.3,
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: unitBookSubject.topic.length,
                ),
              ),
            ],
          ),
       */
            ),
      ],
    );
  }
}
