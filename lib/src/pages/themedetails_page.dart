import 'dart:developer';

import 'package:aritbook10/src/pages/question_page.dart';
import 'package:aritbook10/src/widgets/TheneDetails/topicdeatail.dart';
import 'package:aritbook10/src/widgets/TheneDetails/topicexample.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/UnitModel/unit_model.dart';
import '../widgets/TheneDetails/customappbar.dart';
import '../widgets/TheneDetails/slidinguppaneldetails.dart';
import '../widgets/TheneDetails/unittitle.dart';

class ThemeDetailsScreen extends StatefulWidget {
  const ThemeDetailsScreen({super.key});

  @override
  State<ThemeDetailsScreen> createState() => ThemeDetailsScreenState();
}

List<PanelController> panelControllerList = [];

class ThemeDetailsScreenState extends State<ThemeDetailsScreen> {
  @override
  void dispose() {
    super.dispose();
    panelControllerList.clear();
  }

  @override
  Widget build(BuildContext context) {
    final UnitBook unitBook =
        ModalRoute.of(context)!.settings.arguments as UnitBook;

    for (var element in unitBook.unitSubject) {
      panelControllerList.add(PanelController());
      log(element.toString());
    }
    log(panelControllerList.length.toString());
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            CustomAppBar(unitBook),
            SliverToBoxAdapter(child: UnitTittle(unitBook)),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SlidingUpPanelHomePageWidget(
                      unitBookSubject: unitBook.unitSubject[index],
                      panelOrderPanelController: panelControllerList[index],
                      slidgpanel: [
                        TopicDetail(unitBook),
                        TopicExample(unitBook.unitSubject[index]),
                      ],
                    ),
                  );
                },
                childCount: unitBook.unitSubject.length,
              ),
            ),
            SliverToBoxAdapter(
                child:
                    QuestionPage(questions: unitBook.unitQuestion, type: "")),
            SliverToBoxAdapter(
                child: QuestionPage(
              questions: unitBook.unitQuestion,
              type: "lesson",
            )),
          ],
        ),
      ],
    ));
  }
}
