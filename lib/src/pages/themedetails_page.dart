import 'dart:developer';

import 'package:espe_math/src/pages/geogebra_view_body.dart';
import 'package:espe_math/src/pages/question_page.dart';
import 'package:espe_math/src/widgets/TheneDetails/topicdeatail.dart';
import 'package:espe_math/src/widgets/TheneDetails/topicexample.dart';
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
            SliverToBoxAdapter(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocalHtmlViewer(
                        urlToLaunch: 'https://www.geogebra.org/m/hg3femjc',
                      ),
                    ),
                  );
                },
                child: const Text("Ver libro virtual de Geogebra"),
              ),
            ),
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
          ],
        ),
      ],
    ));
  }
}
