import 'dart:async';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:video_player/video_player.dart';
import '../../../models/UnitModel/unitoption_model.dart';
import '../../../models/UnitModel/unitquestion_model.dart';
import '../../../pages/home_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'dart:math' as math;

class ProblemWidget extends StatefulWidget {
  const ProblemWidget({super.key});

  @override
  State<ProblemWidget> createState() => _ProblemWidgetState();
}

Timer? countdownTimer;

final PanelController _panelToolKitUpPanelController = PanelController();
final PanelController _panelToolKitDownPanelController = PanelController();
MathFieldEditingController polynomialController = MathFieldEditingController();

int _counter = 31;
int totalQuestion = 0;
int _cc = 0;
int score = 0;
int _manyOption = 3;

bool _isToolKitUpPanelPanel = true;
bool _isToolKitDownPanelPanel = true;
bool _isShowingFeedback = false;

bool _answerSended1 = false;
bool _answerSended2 = false;
bool _answerSended3 = false;
bool _answerSended4 = false;

String _textanswerSended1 = "openAngle";
String _textanswerSended2 = "openAngle";
String _textanswerSended3 = "";
String _textanswerSended4 = "";

final List<String> setA = ['2', '3', '5'];
final List<String> setB = ['5', '6', '7', '8', '11'];

enum TypeAngleX { openAngle, closedAngle }

enum TypeAngleY { openAngle, closedAngle }

enum TypeAnbsisa { point1, point2 }

enum TypeYesOrNo { si, no }

late int scoreShow;

late CountDownController _controller;

List<int> showingTooltipOnSpots = [1, 3, 5];
double _equation2P1X = -4;
double _equation2P1Y = 4;

double _equation2P2X = -8;
double _equation2P2Y = 8;

TypeAnbsisa _typeAnbsisa = TypeAnbsisa.point1;
TypeYesOrNo _typeYesOrNo = TypeYesOrNo.si;
late VideoPlayerController videoController;

class _ProblemWidgetState extends State<ProblemWidget> {
  @override
  void initState() {
    super.initState();

    _controller = CountDownController();
    videoController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )..initialize().then((_) {
        setState(() {});
      });
    scoreShow = 0;
  }

  @override
  void dispose() {
    score = 0;
    scoreShow = 0;
    _cc = 0;
    _counter = 31;
    _answerSended1 = false;
    _answerSended2 = false;
    _answerSended3 = false;
    _answerSended4 = false;
    _isShowingFeedback = false;
    _manyOption = 3;
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<UnitQuestion> unitQuestion =
        ModalRoute.of(context)!.settings.arguments as List<UnitQuestion>;
    Size screenMediaSales = MediaQuery.of(context).size;
    totalQuestion = unitQuestion.length;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: (unitQuestion.length > _cc && !_isShowingFeedback)
                  ? Column(
                      children: [
                        _slidingUpOptionUpGraphToolKit(
                            screenMediaSales, unitQuestion),
                        (unitQuestion[_cc].idQuestion.contains("interval"))
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    child: straightEquations(0, unitQuestion)),
                              )
                            : (unitQuestion[_cc].idQuestion.contains("pending"))
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.75,
                                        child: linearEquations2Points(
                                            1, unitQuestion)))
                                : (unitQuestion[_cc]
                                        .idQuestion
                                        .contains("venn"))
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child:
                                                vennEquations(1, unitQuestion)))
                                    : (unitQuestion[_cc]
                                            .idQuestion
                                            .contains("domran"))
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                child: domainAndRange(
                                                    1, unitQuestion)))
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: PageView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: 4,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return SingleChildScrollView(
                                                      child: _questionsWidget(
                                                          index, unitQuestion),
                                                    );
                                                  }),
                                            ),
                                          ),
                      ],
                    )
                  : (_isShowingFeedback)
                      ? widgetFeedback(unitQuestion)
                      : Center(child: endQuestion()),
            ),
            (unitQuestion.length > _cc && !_isShowingFeedback)
                ? Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: _slidingUpOptionDownGraphToolKit(
                        screenMediaSales, unitQuestion),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  String tappedId = "No InkWell!!! Please Tap an InkWell";

  final TeXViewStyle _teXViewStyle = const TeXViewStyle(
    margin: TeXViewMargin.all(10),
    padding: TeXViewPadding.all(10),
    borderRadius: TeXViewBorderRadius.all(10),
    border: TeXViewBorder.all(
      TeXViewBorderDecoration(
          borderColor: Colors.blue,
          borderStyle: TeXViewBorderStyle.solid,
          borderWidth: 2),
    ),
  );

  void tapCallbackHandler(String id) {
    setState(() {
      tappedId = id;
    });
  }
//Panel Superior

  Widget _slidingUpOptionUpGraphToolKit(
      Size media, List<UnitQuestion> questions) {
    return SlidingUpPanel(
        slideDirection: SlideDirection.UP,
        onPanelOpened: () => setState(() {
              _isToolKitDownPanelPanel = false;
            }),
        onPanelClosed: () => setState(() {
              _isToolKitDownPanelPanel = true;
            }),
        controller: _panelToolKitUpPanelController,
        maxHeight: (media.height > 600)
            ? MediaQuery.of(context).size.height * 0.35
            : media.height * 0.4,
        minHeight: (media.height > 600)
            ? MediaQuery.of(context).size.height * 0.05
            : media.height * 0.1,
        header: Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Ejercicio ${_cc + 1}"),
              (_isToolKitDownPanelPanel)
                  ? TextButton.icon(
                      onPressed: () {
                        _panelToolKitUpPanelController.open();
                        setState(() {
                          _isToolKitDownPanelPanel = false;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Theme.of(context).cardColor,
                      ),
                      label: const Text(""))
                  : TextButton.icon(
                      onPressed: () {
                        _panelToolKitUpPanelController.close();
                        setState(() {
                          _isToolKitDownPanelPanel = true;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Theme.of(context).cardColor,
                      ),
                      label: const Text(""))
            ],
          ),
        ),
        panel: (questions[_cc].idQuestion.contains("interval"))
            ? straight1EquationsSlideUpBody(questions)
            : (questions[_cc].idQuestion.contains("pending"))
                ? linearEquations2PointsSlideUpBody(questions)
                : (questions[_cc].idQuestion.contains("venn"))
                    ? vennEquationsSlideUpBody(questions)
                    : (questions[_cc].idQuestion.contains("domran"))
                        ? domainAndRangeSlideUpBody(questions)
                        : Container());
  }

  int currentIndex1 = 0;
  int currentIndex2 = 0;
  Widget straight1EquationsSlideUpBody(List<UnitQuestion> questions) {
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        sliver: SliverToBoxAdapter(
          child: viewNumberOfQuetion(questions[_cc].titleQuestion),
        ),
      ),
    ]);
  }

  Widget linearEquations2PointsSlideUpBody(List<UnitQuestion> questions) {
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1,
        ),
        sliver: SliverToBoxAdapter(
          child: viewNumberOfQuetion(questions[_cc].titleQuestion),
        ),
      ),
      SliverPadding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.05,
        ),
        sliver: SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: TeXView(
                renderingEngine: const TeXViewRenderingEngine.mathjax(),
                onRenderFinished: (height) {
                  log(height.toString());
                },
                child: TeXViewColumn(children: [
                  TeXViewInkWell(
                      child: const TeXViewDocument(
                          r"""<h2>\(m = \frac{{y_2  -  y_1}}{{x_2  -  x_1}}\)</h2>""",
                          style:
                              TeXViewStyle(textAlign: TeXViewTextAlign.center)),
                      style: _teXViewStyle,
                      id: "inkwell_1",
                      rippleEffect: true,
                      onTap: tapCallbackHandler),
                  /* TeXViewInkWell(
                      child: const TeXViewDocument(
                          r"""<h2>\(y = mx  -  b\)</h2>""",
                          style:
                              TeXViewStyle(textAlign: TeXViewTextAlign.center)),
                      style: _teXViewStyle,
                      id: "inkwell_1",
                      rippleEffect: true,
                      onTap: tapCallbackHandler),*/
                ]),
                style: const TeXViewStyle(
                  margin: TeXViewMargin.all(5),
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  border: TeXViewBorder.all(
                    TeXViewBorderDecoration(
                        borderColor: Colors.blue,
                        borderStyle: TeXViewBorderStyle.solid,
                        borderWidth: 5),
                  ),
                  backgroundColor: Colors.white,
                ),
                loadingWidgetBuilder: (context) => const Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                          Text("Rendering...")
                        ],
                      ),
                    )),
          ),
        ),
      ),
    ]);
  }

  Widget vennEquationsSlideUpBody(List<UnitQuestion> questions) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          sliver: SliverToBoxAdapter(
            child: viewNumberOfQuetion(questions[_cc].titleQuestion),
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text("Dominio",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: MathField(
                    keyboardType: MathKeyboardType.expression,
                    variables: const [','],
                    decoration: InputDecoration(
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black)),
                    onSubmitted: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _textanswerSended2 =
                              value.replaceAll(RegExp(r'[{}]+'), '');
                          log(_textanswerSended2);
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text("Rango",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: MathField(
                    keyboardType: MathKeyboardType.expression,
                    variables: const [','],
                    decoration: InputDecoration(
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black)),
                    onSubmitted: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          _textanswerSended3 =
                              value.replaceAll(RegExp(r'[{}]+'), '');
                          log(_textanswerSended3);
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget domainAndRangeSlideUpBody(List<UnitQuestion> questions) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          sliver: SliverToBoxAdapter(
            child: viewNumberOfQuetion(questions[_cc].titleQuestion),
          ),
        ),
      ],
    );
  }

  ///
  /// Panel Inferior
  ///

  Widget _slidingUpOptionDownGraphToolKit(
      Size media, List<UnitQuestion> questions) {
    return SlidingUpPanel(
        slideDirection: SlideDirection.UP,
        onPanelOpened: () => setState(() {
              _isToolKitUpPanelPanel = false;
            }),
        onPanelClosed: () => setState(() {
              _isToolKitUpPanelPanel = true;
            }),
        controller: _panelToolKitDownPanelController,
        maxHeight: (media.height > 600)
            ? MediaQuery.of(context).size.height * 0.8
            : media.height * 0.4,
        minHeight: (media.height > 600)
            ? MediaQuery.of(context).size.height * 0.05
            : media.height * 0.1,
        header: Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Herramienta"),
              (_isToolKitUpPanelPanel)
                  ? TextButton.icon(
                      onPressed: () {
                        _panelToolKitDownPanelController.open();
                        setState(() {
                          _isToolKitUpPanelPanel = false;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Theme.of(context).cardColor,
                      ),
                      label: const Text(""))
                  : TextButton.icon(
                      onPressed: () {
                        _panelToolKitDownPanelController.close();
                        setState(() {
                          _isToolKitUpPanelPanel = true;
                        });
                      },
                      icon: Icon(
                        Icons.arrow_downward,
                        color: Theme.of(context).cardColor,
                      ),
                      label: const Text(""))
            ],
          ),
        ),
        panel: (questions[_cc].idQuestion.contains("interval"))
            ? straight1EquationsSlideDownBody(questions)
            : (questions[_cc].idQuestion.contains("pending"))
                ? linearEquations2PointsSlideDownBody(questions)
                : (questions[_cc].idQuestion.contains("venn"))
                    ? vennEquationsSlideDownBody(questions)
                    : (questions[_cc].idQuestion.contains("domran"))
                        ? domainAndRangeSlideDownBody(questions)
                        : Container());
  }

  Widget straight1EquationsSlideDownBody(List<UnitQuestion> questions) {
    String interval1 = "<";
    String interval2 = "\u2264";
    String interval3 = ">";
    String interval4 = "\u2265";

    List<String> optionString1 = [interval1, interval2, interval3, interval4];
    List<String> optionString2 = [interval1, interval2, interval3, interval4];

    return CustomScrollView(slivers: [
      SliverPadding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        sliver: SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (questions[_cc].idQuestion.contains("(1)"))
                  ? SingleChildScrollView(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.001),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if ((_textanswerSended1 ==
                                                            "openAngle")) {
                                                          _textanswerSended1 =
                                                              "closedAngle";
                                                        } else {
                                                          _textanswerSended1 =
                                                              "openAngle";
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                        (_textanswerSended1 ==
                                                                "openAngle")
                                                            ? "( "
                                                            : "[ ",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: '',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    onChanged: (value) {
                                                      if (value.isNotEmpty) {
                                                        _equationX = value;
                                                        _textanswerSended3 =
                                                            value;
                                                        _generateLineData();
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  child: Text(" , ",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              color: Colors
                                                                  .black)),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.25,
                                                  child: TextField(
                                                    decoration:
                                                        const InputDecoration(
                                                      labelText: '',
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    onChanged: (value) {
                                                      if (value.isNotEmpty) {
                                                        _equationY = value;
                                                        _textanswerSended4 =
                                                            value;
                                                        _generateLineData();
                                                      }
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1),
                                                  child: TextButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        if ((_textanswerSended2 ==
                                                            "openAngle")) {
                                                          _textanswerSended2 =
                                                              "closedAngle";
                                                        } else {
                                                          _textanswerSended2 =
                                                              "openAngle";
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                        (_textanswerSended2 ==
                                                                "openAngle")
                                                            ? " )"
                                                            : " ]",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headlineLarge!
                                                            .copyWith(
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          )),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: SizedBox(
                        height: 200,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15.0),
                                        child: SizedBox.square(
                                          dimension: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: MathField(
                                            keyboardType:
                                                MathKeyboardType.numberOnly,
                                            variables: const ['x'],
                                            decoration: InputDecoration(
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .copyWith(
                                                        color: Colors.black)),
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.isNotEmpty) {
                                                  _equationX = value;
                                                  _textanswerSended3 = value;
                                                  _generateLineData();
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox.square(
                                          dimension: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Padding(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox.square(
                                                      dimension:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            currentIndex1 =
                                                                (currentIndex1 +
                                                                        1) %
                                                                    optionString1
                                                                        .length;
                                                            if (optionString1[
                                                                        currentIndex1] ==
                                                                    "<" ||
                                                                optionString1[
                                                                        currentIndex1] ==
                                                                    ">") {
                                                              _textanswerSended1 =
                                                                  "openAngle";
                                                            } else {
                                                              _textanswerSended1 =
                                                                  "closedAngle";
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                            optionString1[
                                                                currentIndex1],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineLarge!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black)),
                                                      )),
                                                  Text("X",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineLarge!
                                                          .copyWith(
                                                              color: Colors
                                                                  .black)),
                                                  SizedBox.square(
                                                      dimension:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.2,
                                                      child: TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            currentIndex2 =
                                                                (currentIndex2 +
                                                                        1) %
                                                                    optionString2
                                                                        .length;
                                                            if (optionString2[
                                                                        currentIndex2] ==
                                                                    "<" ||
                                                                optionString2[
                                                                        currentIndex2] ==
                                                                    ">") {
                                                              _textanswerSended2 =
                                                                  "openAngle";
                                                            } else {
                                                              _textanswerSended2 =
                                                                  "closedAngle";
                                                            }
                                                          });
                                                        },
                                                        child: Text(
                                                            optionString2[
                                                                currentIndex2],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headlineLarge!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black)),
                                                      )),
                                                ],
                                              ))),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10.0),
                                        child: SizedBox.square(
                                          dimension: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          child: MathField(
                                            keyboardType:
                                                MathKeyboardType.numberOnly,
                                            variables: const ['x'],
                                            decoration: InputDecoration(
                                                labelStyle: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge!
                                                    .copyWith(
                                                        color: Colors.black)),
                                            onChanged: (value) {
                                              setState(() {
                                                if (value.isNotEmpty) {
                                                  _equationY = value;
                                                  _textanswerSended4 = value;
                                                  _generateLineData();
                                                }
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: OutlinedButton(
                      onPressed: () {
                        sendAnswer(questions, 0);
                      },
                      child: const Text("Responder la Pregunta"))),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget linearEquations2PointsSlideDownBody(List<UnitQuestion> questions) {
    return CustomScrollView(slivers: [
      SliverPadding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        sliver: SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.25),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Radio<TypeAnbsisa>(
                                  value: TypeAnbsisa.point1,
                                  groupValue: _typeAnbsisa,
                                  onChanged: (TypeAnbsisa? value) {
                                    setState(() {
                                      _typeAnbsisa = value!;
                                      _textanswerSended1 =
                                          value.toString().split('.').last;
                                      log(_textanswerSended1);
                                    });
                                  },
                                ),
                                Text('Punto 1',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.black)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio<TypeAnbsisa>(
                              value: TypeAnbsisa.point2,
                              groupValue: _typeAnbsisa,
                              onChanged: (TypeAnbsisa? value) {
                                setState(() {
                                  _typeAnbsisa = value!;
                                  _textanswerSended1 =
                                      value.toString().split('.').last;
                                  log(_textanswerSended2);
                                });
                              },
                            ),
                            Text('Punto 2',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width * 0.1),
                    child: Text("m = ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                    child: MathField(
                      keyboardType: MathKeyboardType.numberOnly,
                      variables: const ['x'],
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black)),
                      onSubmitted: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            _textanswerSended3 = value;
                            log(value);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width * 0.1),
                    child: Text("y = ",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.width * 0.25,
                    child: MathField(
                      keyboardType: MathKeyboardType.expression,
                      variables: const ['x'],
                      decoration: InputDecoration(
                          labelStyle: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(color: Colors.black)),
                      onSubmitted: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            _textanswerSended4 = value;
                            log(value);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: OutlinedButton(
                      onPressed: () {
                        sendAnswer(questions, 1);
                      },
                      child: const Text("Responder la Pregunta"))),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget vennEquationsSlideDownBody(List<UnitQuestion> questions) {
    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: [
        SliverPadding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("Par ordernados",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(color: Colors.black)),
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: orderedPairs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                orderedPairs[index],
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              LineChart(
                                LineChartData(
                                  minX: -10,
                                  maxX: 10,
                                  maxY: 10,
                                  minY: -10,
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: true,
                                    drawHorizontalLine: true,
                                    getDrawingVerticalLine: (value) {
                                      if (value == 0) {
                                        return const FlLine(
                                          color: Colors.blue,
                                          strokeWidth: 2.0,
                                        );
                                      } else {
                                        return const FlLine(
                                          color: Colors.grey,
                                          strokeWidth: 0.5,
                                        );
                                      }
                                    },
                                    getDrawingHorizontalLine: (value) {
                                      if (value == 0) {
                                        return const FlLine(
                                          color: Colors.blue,
                                          strokeWidth: 2.0,
                                        );
                                      } else {
                                        return const FlLine(
                                          color: Colors.grey,
                                          strokeWidth: 0.5,
                                        );
                                      }
                                    },
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border: const Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 1),
                                      right: BorderSide(
                                          color: Colors.blue, width: 1),
                                    ),
                                  ),
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: _data7P,
                                      isCurved: false,
                                      color: Colors.red,
                                      barWidth: 2.0,
                                      dashArray: [5, 5],
                                      dotData: const FlDotData(
                                        show: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: OutlinedButton(
                    onPressed: () {
                      sendAnswer(questions, 1);
                    },
                    child: const Text("Responder la Pregunta"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String domAngle1 = "openAngle";
  String domAnlge2 = "openAngle";
  String ranAngle1 = "openAngle";
  String ranAnlge2 = "openAngle";
  Widget domainAndRangeSlideDownBody(List<UnitQuestion> questions) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio<TypeYesOrNo>(
                            value: TypeYesOrNo.si,
                            groupValue: _typeYesOrNo,
                            onChanged: (TypeYesOrNo? value) {
                              setState(() {
                                _typeYesOrNo = value!;
                                _textanswerSended1 =
                                    value.toString().split('.').last;
                                log(_textanswerSended1);
                              });
                            },
                          ),
                          Text('Si es una funcion',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<TypeYesOrNo>(
                            value: TypeYesOrNo.no,
                            groupValue: _typeYesOrNo,
                            onChanged: (TypeYesOrNo? value) {
                              setState(() {
                                _typeYesOrNo = value!;
                                _textanswerSended1 =
                                    value.toString().split('.').last;
                                log(_textanswerSended1);
                              });
                            },
                          ),
                          Text('No es una funcion',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              bottom: MediaQuery.of(context).size.width * 0.1),
                          child: Text("Dominio : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.black)),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: TextButton(
                              onPressed: () {
                                if (domAngle1 == "openAngle") {
                                  setState(() {
                                    domAngle1 = "closedAngle";
                                  });
                                } else {
                                  setState(() {
                                    domAngle1 = "openAngle";
                                  });
                                }
                              },
                              child: Text(
                                  (domAngle1 == "openAngle") ? " (" : " [",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: Colors.black)),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.25,
                          child: MathField(
                            keyboardType: MathKeyboardType.expression,
                            variables: const ['x', "\u221E", "R", ","],
                            decoration: InputDecoration(
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black)),
                            onSubmitted: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  _textanswerSended2 = domAngle1
                                          .replaceAll(r'openAngle', "(")
                                          .replaceAll(r'closedAngle', "[") +
                                      value.replaceAll(RegExp(r'[{}]+'), '') +
                                      domAnlge2
                                          .replaceAll(r'openAngle', ")")
                                          .replaceAll(r'closedAngle', "]");
                                  log(_textanswerSended2);
                                }
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.1),
                          child: TextButton(
                            onPressed: () {
                              if (domAnlge2 == "openAngle") {
                                setState(() {
                                  domAnlge2 = "closedAngle";
                                });
                              } else {
                                setState(() {
                                  domAnlge2 = "openAngle";
                                });
                              }
                            },
                            child: Text(
                                (domAnlge2 == "openAngle") ? " )" : " ]",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1,
                              bottom: MediaQuery.of(context).size.width * 0.1),
                          child: Text("Rango : ",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.black)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.1),
                          child: TextButton(
                            onPressed: () {
                              if (ranAngle1 == "openAngle") {
                                setState(() {
                                  ranAngle1 = "closedAngle";
                                });
                              } else {
                                setState(() {
                                  ranAngle1 = "openAngle";
                                });
                              }
                            },
                            child: Text(
                                (ranAngle1 == "openAngle") ? " (" : " [",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.25,
                          child: MathField(
                            keyboardType: MathKeyboardType.expression,
                            variables: const ['x', "\u221E", "R", ","],
                            decoration: InputDecoration(
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black)),
                            onSubmitted: (value) {
                              setState(() {
                                if (value.isNotEmpty) {
                                  _textanswerSended3 = ranAngle1
                                          .replaceAll(r'openAngle', "(")
                                          .replaceAll(r'closedAngle', "[") +
                                      value.replaceAll(RegExp(r'[{}]+'), '') +
                                      ranAnlge2
                                          .replaceAll(r'openAngle', ")")
                                          .replaceAll(r'closedAngle', "]");

                                  log(_textanswerSended3);
                                }
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.1),
                          child: TextButton(
                            onPressed: () {
                              if (ranAnlge2 == "openAngle") {
                                setState(() {
                                  ranAnlge2 = "closedAngle";
                                });
                              } else {
                                setState(() {
                                  ranAnlge2 = "openAngle";
                                });
                              }
                            },
                            child: Text(
                                (ranAnlge2 == "openAngle") ? " )" : " ]",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(color: Colors.black)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: OutlinedButton(
                        onPressed: () {
                          sendAnswer(questions, 1);
                        },
                        child: const Text("Responder la Pregunta"))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Ejericios de Graficar una Recta en X
  ///

  String _equationX = "";
  String _equationY = "";

  List<FlSpot> _data1P = [];

  void _generateLineData() {
    if (_equationX.isEmpty || _equationY.isEmpty) {
      return;
    }

    final double x1 = double.parse(_equationX);
    final double x2 = double.parse(_equationY);

    final List<FlSpot> data = [
      FlSpot(x1, 0),
      FlSpot(x2, 0),
    ];

    setState(() {
      _data1P = data;
    });
  }

  Widget straightEquations(int index, List<UnitQuestion> questions) {
    String typenAngle1 = questions[_cc].option[0].answerOption;
    String typenAngle2 = questions[_cc].option[1].answerOption;

    int num1 = int.tryParse(questions[_cc].option[2].answerOption)!;
    int num2 = int.tryParse(questions[_cc].option[3].answerOption)!;

    String latexExpression = "";
    if (typenAngle1 == "openAngle" && typenAngle2 == "openAngle") {
      latexExpression = num1 < num2
          ? "<h2>\\(${num1.toString()} < x < ${num2.toString()}\\)</h2>"
          : "<h2>\\(${num1.toString()} > x > ${num2.toString()}\\)</h2>";
    } else if (typenAngle1 == "closedAngle" && typenAngle2 == "closedAngle") {
      latexExpression = num1 < num2
          ? "<h2>\\(${num1.toString()} \\leq x \\leq ${num2.toString()}\\)</h2>"
          : "<h2>\\(${num1.toString()} \\geq x \\geq ${num2.toString()}\\)</h2>";
    } else if (typenAngle1 == "openAngle" && typenAngle2 == "closedAngle") {
      latexExpression = num1 < num2
          ? "<h2>\\(${num1.toString()} < x \\leq ${num2.toString()}\\)</h2>"
          : "<h2>\\(${num1.toString()} > x \\geq ${num2.toString()}\\)</h2>";
    } else if (typenAngle1 == "closedAngle" && typenAngle2 == "openAngle") {
      latexExpression = num1 < num2
          ? "<h2>\\(${num1.toString()} \\leq x < ${num2.toString()}\\)</h2>"
          : "<h2>\\(${num1.toString()} \\geq x > ${num2.toString()}\\)</h2>";
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      (questions[_cc].idQuestion.contains("(1)"))
          ? SizedBox(
              height: 200,
              child: TeXView(
                  renderingEngine: const TeXViewRenderingEngine.mathjax(),
                  onRenderFinished: (height) {},
                  child: TeXViewColumn(children: [
                    TeXViewInkWell(
                        child: TeXViewDocument(latexExpression,
                            style: const TeXViewStyle(
                                textAlign: TeXViewTextAlign.center)),
                        style: _teXViewStyle,
                        id: "inkwell_1",
                        rippleEffect: true,
                        onTap: tapCallbackHandler),
                  ]),
                  style: const TeXViewStyle(
                    margin: TeXViewMargin.all(2),
                    padding: TeXViewPadding.all(5),
                    borderRadius: TeXViewBorderRadius.all(5),
                    border: TeXViewBorder.all(
                      TeXViewBorderDecoration(
                          borderColor: Colors.blue,
                          borderStyle: TeXViewBorderStyle.solid,
                          borderWidth: 5),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  loadingWidgetBuilder: (context) => const Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CircularProgressIndicator(),
                            Text("Rendering...")
                          ],
                        ),
                      )),
            )
          : Container(),
      (questions[_cc].idQuestion.contains("(1)"))
          ? Container()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.2),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Text(
                                    (typenAngle1.contains("openAngle"))
                                        ? "( "
                                        : "[ ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: Colors.black)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Text(" $num1 ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: Colors.black)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Text(" , ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: Colors.black)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Text(" $num2 ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: Colors.black)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).size.width *
                                        0.1),
                                child: Text(
                                    (typenAngle2.contains("openAngle"))
                                        ? " )"
                                        : " ]",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: Colors.black)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              maxY: 1,
              minY: -1,
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  if (value == 0) {
                    return const FlLine(
                      color: Colors.blue,
                      strokeWidth: 2.0,
                    );
                  } else {
                    return const FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  }
                },
              ),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  bottom: BorderSide(color: Colors.grey, width: 0.5),
                  left: BorderSide(color: Colors.grey, width: 0.5),
                  right: BorderSide(color: Colors.grey, width: 0.5),
                  top: BorderSide(color: Colors.grey, width: 0.5),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: _data1P,
                  isCurved: false,
                  color: Colors.red,
                  barWidth: 2.0,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      if (_textanswerSended1 == "openAngle" &&
                          _textanswerSended2 == "openAngle") {
                        return FlDotCirclePainter(
                          radius: 2.0,
                          strokeWidth: 2.0,
                          strokeColor: Colors.red,
                          color: Colors.white,
                        );
                      } else {
                        return FlDotCirclePainter(
                          radius: 2.0,
                          strokeWidth: 2.0,
                          strokeColor: Colors.red,
                          color: _textanswerSended1 == "closedAngle" &&
                                  _textanswerSended2 == "closedAngle"
                              ? Colors.red
                              : index == 1 &&
                                      _textanswerSended1 == "closedAngle"
                                  ? Colors.white
                                  : index == 0 &&
                                          _textanswerSended2 == "closedAngle"
                                      ? Colors.white
                                      : Colors.red,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  ///
  /// Ejericio de Graficar una Recta con 2 Puntos
  ///

  List<FlSpot> _data2P = [];
  List<FlSpot> _data3P = [];
  List<FlSpot> _data3Pf = [];
  List<Line> lineList = [
    // Agrega más líneas según sea necesario
  ];
  bool canMovePoint = true;
  Widget linearEquations2Points(int index, List<UnitQuestion> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTapDown: (_) {
                // Bloquear el movimiento del punto al iniciar el toque
                setState(() {
                  canMovePoint = false;
                });
              },
              onTapUp: (_) {
                // Permitir el movimiento del punto al finalizar el toque
                setState(() {
                  canMovePoint = true;
                });
              },
              child: Stack(
                children: [
                  LineChart(
                    LineChartData(
                      lineTouchData: LineTouchData(
                        handleBuiltInTouches: true,
                        enabled: true,
                        touchCallback: (event, touchResponse) {
                          if (event.isInterestedForInteractions &&
                              touchResponse != null) {
                            double touchX = event.localPosition!.dx;
                            double touchY = event.localPosition!.dy;
                            // Rango específico del gráfico
                            double minX = -10;
                            double maxX = 0;
                            double minY = 0;
                            double maxY = 10;

                            // Dimensiones del área del gráfico
                            double chartWidth =
                                MediaQuery.of(context).size.width -
                                    MediaQuery.of(context).size.width * 0.35;
                            double chartHeight =
                                MediaQuery.of(context).size.height * 0.4;
                            // Conversión de escala
                            double convertedX =
                                ((touchX / chartWidth) * (maxX - minX)) + minX;
                            double convertedY =
                                ((1 - (touchY / chartHeight)) * (maxY - minY)) +
                                    minY;

                            final List<FlSpot> data = [
                              FlSpot(convertedX.ceilToDouble(),
                                  convertedY.ceilToDouble()),
                              FlSpot(0, convertedY.ceilToDouble()),
                              FlSpot(convertedX.ceilToDouble(),
                                  convertedY.ceilToDouble()),
                              FlSpot(convertedX.ceilToDouble(), 0),
                            ];
                            if (_typeAnbsisa == TypeAnbsisa.point1) {
                              setState(() {
                                _data2P = data;
                              });
                            } else {
                              setState(() {
                                _data3P = data;
                              });
                            }
                            if (_data2P.isNotEmpty && _data3P.isNotEmpty) {
                              _textanswerSended1 =
                                  "(${_data2P.first.x.toInt()},${_data2P.first.y.toInt()})";
                              _textanswerSended2 =
                                  "(${_data3P.first.x.toInt()},${_data3P.first.y.toInt()})";
                              log(_textanswerSended1);
                              log(_textanswerSended2);
                              _data3Pf = [
                                FlSpot(_data2P.first.x, _data2P.first.y),
                                FlSpot(_data3P.first.x, _data3P.first.y),
                              ];
                            }
                          }
                        },
                      ),
                      minX: -10,
                      maxX: 0,
                      maxY: 10,
                      minY: 0,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        drawHorizontalLine: true,
                        getDrawingVerticalLine: (value) {
                          if (value == 0) {
                            return const FlLine(
                              color: Colors.blue,
                              strokeWidth: 2.0,
                            );
                          } else {
                            return const FlLine(
                              color: Colors.grey,
                              strokeWidth: 0.5,
                            );
                          }
                        },
                        getDrawingHorizontalLine: (value) {
                          if (value == 0) {
                            return const FlLine(
                              color: Colors.blue,
                              strokeWidth: 2.0,
                            );
                          } else {
                            return const FlLine(
                              color: Colors.grey,
                              strokeWidth: 0.5,
                            );
                          }
                        },
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: const Border(
                          bottom: BorderSide(color: Colors.blue, width: 1),
                          right: BorderSide(color: Colors.blue, width: 1),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: _data2P,
                          isCurved: false,
                          color: Colors.red,
                          barWidth: 2.0,
                          dashArray: [5, 5],
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              if (_textanswerSended1 == "openAngle" &&
                                  _textanswerSended2 == "openAngle") {
                                return FlDotCirclePainter(
                                  radius: 2.0,
                                  strokeWidth: 2.0,
                                  strokeColor: Colors.red,
                                  color: Colors.white,
                                );
                              } else {
                                return FlDotCirclePainter(
                                  radius: 2.0,
                                  strokeWidth: 2.0,
                                  strokeColor: Colors.red,
                                  color: _textanswerSended1 == "closedAngle" &&
                                          _textanswerSended2 == "closedAngle"
                                      ? Colors.red
                                      : index == 1 &&
                                              _textanswerSended1 ==
                                                  "closedAngle"
                                          ? Colors.white
                                          : index == 0 &&
                                                  _textanswerSended2 ==
                                                      "closedAngle"
                                              ? Colors.white
                                              : Colors.red,
                                );
                              }
                            },
                          ),
                        ),
                        LineChartBarData(
                          spots: _data3P,
                          isCurved: false,
                          color: Colors.blue,
                          barWidth: 2.0,
                          dashArray: [5, 5],
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              if (_textanswerSended1 == "openAngle" &&
                                  _textanswerSended2 == "openAngle") {
                                return FlDotCirclePainter(
                                  radius: 2.0,
                                  strokeWidth: 2.0,
                                  strokeColor: Colors.blue,
                                  color: Colors.white,
                                );
                              } else {
                                return FlDotCirclePainter(
                                  radius: 2.0,
                                  strokeWidth: 2.0,
                                  strokeColor: Colors.blue,
                                  color: _textanswerSended1 == "closedAngle" &&
                                          _textanswerSended2 == "closedAngle"
                                      ? Colors.blue
                                      : index == 1 &&
                                              _textanswerSended1 ==
                                                  "closedAngle"
                                          ? Colors.white
                                          : index == 0 &&
                                                  _textanswerSended2 ==
                                                      "closedAngle"
                                              ? Colors.white
                                              : Colors.blue,
                                );
                              }
                            },
                          ),
                        ),
                        LineChartBarData(
                          spots: _data3Pf,
                          isCurved: false,
                          color: Colors.green,
                          barWidth: 2.0,
                          dotData: const FlDotData(
                            show: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  int selectedSetAIndex = -1;
  int selectedSetBIndex = -1;
  List<String> orderedPairs = [];
  List<FlSpot> _data7P = [];

  String orderedPair = "";
  int cont = 0;
  late double mostLeftSpot = 0.0;
  Widget vennEquations(int index, List<UnitQuestion> questions) {
    String equationSF = questions[_cc].option[3].answerOption;
    _textanswerSended4 = equationSF;
    log(_textanswerSended4);
    String latexExpression = "<h2>\\( f(x) = { $equationSF } \\)</h2>";
    return CustomScrollView(
      scrollDirection: Axis.horizontal,
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
                child: TeXView(
                    renderingEngine: const TeXViewRenderingEngine.mathjax(),
                    onRenderFinished: (height) {
                      log(height.toString());
                    },
                    child: TeXViewColumn(children: [
                      TeXViewInkWell(
                          child: TeXViewDocument(latexExpression,
                              style: const TeXViewStyle(
                                  textAlign: TeXViewTextAlign.center)),
                          style: _teXViewStyle,
                          id: "inkwell_1",
                          rippleEffect: true,
                          onTap: tapCallbackHandler),
                    ]),
                    style: const TeXViewStyle(
                      margin: TeXViewMargin.all(5),
                      padding: TeXViewPadding.all(10),
                      borderRadius: TeXViewBorderRadius.all(10),
                      border: TeXViewBorder.all(
                        TeXViewBorderDecoration(
                            borderColor: Colors.blue,
                            borderStyle: TeXViewBorderStyle.solid,
                            borderWidth: 5),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    loadingWidgetBuilder: (context) => const Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(),
                              Text("Rendering...")
                            ],
                          ),
                        )),
              ),
              Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Card(
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Card(
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: ListView.builder(
                                  itemCount: setA.length,
                                  itemBuilder: (context, index) {
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      child: ListTile(
                                        titleAlignment:
                                            ListTileTitleAlignment.center,
                                        title: Text(
                                          setA[index],
                                          textAlign: TextAlign.center,
                                        ),
                                        tileColor: selectedSetAIndex == index
                                            ? Colors.green
                                            : null,
                                        onTap: () {
                                          setState(() {
                                            selectedSetAIndex = index;
                                            if (selectedSetBIndex != -1) {
                                              orderedPair =
                                                  '(${setA[selectedSetAIndex]}, ${setB[selectedSetBIndex]})';
                                            }
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (selectedSetAIndex != -1 &&
                              selectedSetBIndex != -1)
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                child: ListView.builder(
                                  itemCount: lineList.length,
                                  itemBuilder: (context, index) {
                                    final line = lineList[index];
                                    return Card(
                                      child: CustomPaint(
                                        painter: LinePainter(
                                          startPoint: line.startPoint,
                                          endPoint: line.endPoint,
                                          color: line.color,
                                          strokeWidth: line.strokeWidth,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Card(
                              color: Colors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width: MediaQuery.of(context).size.width * 0.25,
                                child: ListView.builder(
                                  itemCount: setB.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: Text(
                                          setB[index],
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      tileColor: selectedSetBIndex == index
                                          ? Colors.green
                                          : null,
                                      onTap: () {
                                        setState(() {
                                          selectedSetBIndex = index;
                                          orderedPair =
                                              '(${setA[selectedSetAIndex]}, ${setB[selectedSetBIndex]})';
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: OutlinedButton(
                              onPressed: () {
                                FToast fToast = FToast();
                                fToast.init(context);

                                double evaluated1 = evaluateExpression(
                                    "2\\cdot{${double.tryParse(orderedPair.split(",")[0].split("(")[1])}}+1",
                                    double.tryParse(orderedPair
                                        .split(",")[0]
                                        .split("(")[1])!);

                                if (evaluated1 ==
                                    double.tryParse(orderedPair
                                        .split(",")[1]
                                        .split(")")[0])!) {
                                  if (!orderedPairs.contains(orderedPair)) {
                                    cont++;

                                    _textanswerSended1 = cont.toString();
                                    log(_textanswerSended1);
                                    setState(() {
                                      orderedPairs.add(orderedPair);

                                      _data7P.add(FlSpot(
                                          double.tryParse(orderedPair
                                              .split(",")[0]
                                              .split("(")[1])!,
                                          double.tryParse(orderedPair
                                              .split(",")[1]
                                              .split(")")[0])!));

                                      lineList.add(Line(
                                          startPoint:
                                              Offset(
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.3,
                                                  selectedSetBIndex.toDouble() *
                                                      (MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.15)),
                                          endPoint: Offset(
                                              -MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.23,
                                              selectedSetAIndex.toDouble() *
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1)),
                                          color: Colors.black,
                                          strokeWidth: 1));
                                    });
                                  } else {
                                    fToast.showToast(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        child: Card(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Esta par ordenado ya existe",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              color:
                                                                  Colors.black),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    'assets/images/thumnbdown.gif',
                                                    width: 100,
                                                    height: 100,
                                                    fit: BoxFit.contain,
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      gravity: ToastGravity.CENTER,
                                    );
                                  }
                                } else {
                                  fToast.showToast(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
                                      child: Card(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Par ordenado ncorrecto",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall!
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                Image.asset(
                                                  'assets/images/thumnbdown.gif',
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.contain,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    gravity: ToastGravity.CENTER,
                                  );
                                }
                              },
                              child: const Text("Generar Par Odenado"))),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          lineList.clear();
                          _data7P.clear();
                          orderedPairs.clear();
                        });
                      },
                      child: const Text("Limpiar la grafica"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///
  ///

  List<FlSpot> _data4P = [];
  List<FlSpot> _data5P = [];
  List<FlSpot> _data6P = [];

  List<FlSpot> generatePolynomialData(String expression) {
    String polynomial = expression;

    List<FlSpot> data = [];

    // Evaluamos la función polinómica para cada valor de x en el rango deseado
    for (double x = -10; x <= 10; x += 1) {
      String expression = polynomial.replaceAll('x', x.toString());
      double y = evaluateExpression(expression, x);
      if (y.isFinite) {
        data.add(FlSpot(x, y));
      }
    }

    return data;
  }

  double evaluateExpression(String expression, double x) {
    if (expression.contains('sqrt') && x < 0) {
      return double.nan; // Retorna NaN para valores negativos en raíz cuadrada
    }

    Expression exp = TeXParser(expression).parse();
    ContextModel contextModel = ContextModel();

    return exp.evaluate(EvaluationType.REAL, contextModel);
  }

  buildGraph(String expresion) {
    _data4P = [
      FlSpot(_equation2P1X, _equation2P1Y),
      FlSpot(0, _equation2P1Y),
      FlSpot(_equation2P1X, _equation2P1Y),
      FlSpot(_equation2P1X, 0),
    ];

    _data5P = [
      FlSpot(_equation2P2X, _equation2P2Y),
      FlSpot(0, _equation2P2Y),
      FlSpot(_equation2P2X, _equation2P2Y),
      FlSpot(_equation2P2X, 0),
    ];

    _data6P = generatePolynomialData(expresion);
  }

  Widget domainAndRange(int index, List<UnitQuestion> questions) {
    String equationSF = questions[_cc].option[3].answerOption;
    _textanswerSended4 = equationSF;
    log(_textanswerSended4);
    String latexExpression = "<h2>\\( f(x) = { $equationSF } \\)</h2>";
    buildGraph(equationSF);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TeXView(
            renderingEngine: const TeXViewRenderingEngine.mathjax(),
            onRenderFinished: (height) {},
            child: TeXViewColumn(children: [
              TeXViewInkWell(
                  child: TeXViewDocument(latexExpression,
                      style: const TeXViewStyle(
                          textAlign: TeXViewTextAlign.center)),
                  style: _teXViewStyle,
                  id: "inkwell_1",
                  rippleEffect: true,
                  onTap: tapCallbackHandler),
            ]),
            style: const TeXViewStyle(
              margin: TeXViewMargin.all(5),
              padding: TeXViewPadding.all(10),
              borderRadius: TeXViewBorderRadius.all(10),
              border: TeXViewBorder.all(
                TeXViewBorderDecoration(
                    borderColor: Colors.blue,
                    borderStyle: TeXViewBorderStyle.solid,
                    borderWidth: 5),
              ),
              backgroundColor: Colors.white,
            ),
            loadingWidgetBuilder: (context) => const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text("Rendering...")
                    ],
                  ),
                )),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                LineChart(
                  LineChartData(
                    minX: -10,
                    maxX: 10,
                    maxY: 10,
                    minY: -10,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: true,
                      drawHorizontalLine: true,
                      getDrawingVerticalLine: (value) {
                        if (value == 0) {
                          return const FlLine(
                            color: Colors.blue,
                            strokeWidth: 2.0,
                          );
                        } else {
                          return const FlLine(
                            color: Colors.grey,
                            strokeWidth: 0.5,
                          );
                        }
                      },
                      getDrawingHorizontalLine: (value) {
                        if (value == 0) {
                          return const FlLine(
                            color: Colors.blue,
                            strokeWidth: 2.0,
                          );
                        } else {
                          return const FlLine(
                            color: Colors.grey,
                            strokeWidth: 0.5,
                          );
                        }
                      },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(color: Colors.blue, width: 1),
                        right: BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: _data6P,
                        isCurved: false,
                        color: Colors.green,
                        barWidth: 2.0,
                        dotData: const FlDotData(
                          show: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// Trivia
  ///

  _questionsWidget(int index, List<UnitQuestion> questions) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: viewNumberOfQuetion(questions[_cc].titleQuestion),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.05,
              top: MediaQuery.of(context).size.height * 0.05),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _answerSended1 = true;
                    _textanswerSended1 = "1";
                  });
                },
                child: Card(
                  child: productCard(questions, 0),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _answerSended2 = true;
                    _textanswerSended2 = "1";
                  });
                },
                child: Card(
                  child: productCard(questions, 1),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.1),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _answerSended3 = true;
                    _textanswerSended3 = "1";
                  });
                },
                child: Card(
                  child: productCard(questions, 2),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _answerSended4 = true;
                    _textanswerSended4 = "1";
                  });
                },
                child: Card(
                  child: productCard(questions, 3),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  void restartQuestion(List<UnitQuestion> data) {
    _manyOption = 3;

    score = 0;
    _isToolKitUpPanelPanel = true;
    _isToolKitDownPanelPanel = true;
    _isShowingFeedback = true;
    _answerSended1 = false;
    _answerSended2 = false;
    _answerSended3 = false;
    _answerSended4 = false;

    _textanswerSended1 = "";
    _textanswerSended2 = "";
    _textanswerSended3 = "";
    _textanswerSended4 = "";

    _equationX = "";
    _equationY = "";
    orderedPair = "";

    _equation2P1X = -4;
    _equation2P1Y = 4;

    _equation2P2X = -8;
    _equation2P2Y = 8;

    _data1P = [];
    _data2P = [];

    _counter = 31;

    if (data.length > _cc) {
      Timer(const Duration(milliseconds: 31), () {
        if (mounted) {
          _controller.restart(duration: _counter);
        }
      });
    }
  }

  void sendAnswer(List<UnitQuestion> data, int index) {
    log("se responde $_textanswerSended1 ,  $_textanswerSended2 ,  $_textanswerSended3 ,  $_textanswerSended4");
    log("se pregunta ${data[_cc].option[0].answerOption} ,  ${data[_cc].option[1].answerOption} ,  ${data[_cc].option[2].answerOption} ,  ${data[_cc].option[3].answerOption}");
    _controller.pause();
    _counter = 31;
    if (_manyOption > 0) {
      if (data[_cc].option[0].answerOption == _textanswerSended1 &&
          data[_cc].option[1].answerOption == _textanswerSended2 &&
          data[_cc].option[2].answerOption == _textanswerSended3 &&
          data[_cc].option[3].answerOption == _textanswerSended4) {
        log("Se pulsado el boton $index");
        setState(() {
          _answerSended1 = data[_cc].option[0].isTheCorrectOption;
          _answerSended2 = data[_cc].option[1].isTheCorrectOption;
          _answerSended3 = data[_cc].option[2].isTheCorrectOption;
          _answerSended4 = data[_cc].option[3].isTheCorrectOption;

          scoreShow = scoreShow + _manyOption;
          _manyOption = _manyOption - 3;
          showCorrectAnswerWithMessage(context, "");
          restartQuestion(data);
        });
      } else {
        score = 0;
        _manyOption = _manyOption - 1;
        (index == 0)
            ? _answerSended1 = true
            : (index == 1)
                ? _answerSended2 = true
                : (index == 2)
                    ? _answerSended3 = true
                    : (index == 3)
                        ? _answerSended4 = true
                        : _answerSended4 = true;
        log("Se pulsado el boton $index");
        showInCorrectAnswerWithMessage(context, "");
        if (_manyOption == 0) {
          setState(() {
            restartQuestion(data);
          });
        }
      }
    }
  }

  Widget productCard(List<UnitQuestion> data, int index) {
    return data.isNotEmpty
        ? GestureDetector(
            onTap: () {
              _controller.pause();
              _counter = 31;
              if (_manyOption > 0) {
                if (data[_cc].option[index].isTheCorrectOption) {
                  log("Se pulsado el boton $index");
                  setState(() {
                    _answerSended1 = data[_cc].option[0].isTheCorrectOption;
                    _answerSended2 = data[_cc].option[1].isTheCorrectOption;
                    _answerSended3 = data[_cc].option[2].isTheCorrectOption;
                    _answerSended4 = data[_cc].option[3].isTheCorrectOption;
                    scoreShow = scoreShow + _manyOption;
                    _manyOption = _manyOption - 3;
                    restartQuestion(data);
                    showCorrectAnswerWithMessage(context, "");
                  });
                } else {
                  score = 0;
                  _manyOption = _manyOption - 3;
                  (index == 0)
                      ? _answerSended1 = true
                      : (index == 1)
                          ? _answerSended2 = true
                          : (index == 2)
                              ? _answerSended3 = true
                              : (index == 3)
                                  ? _answerSended4 = true
                                  : _answerSended4 = true;
                  log("Se pulsado el boton $index");
                  setState(() {
                    restartQuestion(data);
                  });

                  showInCorrectAnswerWithMessage(
                      context, "Respuesta Incorrecta");
                }
              }
            },
            child: Column(children: [
              productCardWidget(data[_cc].option, index),
            ]),
          )
        : const Padding(
            padding: EdgeInsets.all(0),
          );
  }

  bodyEndQuestion() {
    double scorefinal = (3 * scoreShow) / (totalQuestion * 3);
    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Card(
            color: Theme.of(context).focusColor,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.9,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text("\n Nota Final \n",
                            style: Theme.of(context).textTheme.headline5,
                            textAlign: TextAlign.center),
                        Text("$scoreShow",
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        RatingBarIndicator(
                          rating: scorefinal,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 3,
                          itemSize: 50.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  endQuestion() {
    return Column(
      children: [
        bodyEndQuestion(),
        Card(
          child: OutlinedButton(
              onPressed: (() {
                setState(() {
                  
                  score = 0;
                  _cc = 0;
                  scoreShow = 0;
                  _counter = 31;
                  _answerSended1 = false;
                  _answerSended2 = false;
                  _answerSended3 = false;
                  _answerSended4 = false;
                  _manyOption = 3;
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return const MyHomePage(
                      title: "Pagina Principal",
                    );
                  }));
                });
              }),
              child: Text("Regresar",
                  style: Theme.of(context).textTheme.headlineMedium)),
        ),
      ],
    );
  }

  bodyWidgetFeedBack(List<UnitQuestion> questions) {
    return Stack(
      children: [
        Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("\n Retroalimentación \n",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center),
                  Text(
                      (questions[_cc].feedBackQuestion.isNotEmpty)
                          ? "\n${questions[_cc].feedBackQuestion}\n"
                          : "Sin Texto",
                      style: Theme.of(context).textTheme.labelLarge,
                      textAlign: TextAlign.justify),
                  (questions[_cc].urlImageOrVideoQuestion.contains("video"))
                      ? Column(
                          children: [
                            Center(
                              child: videoController.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio:
                                          videoController.value.aspectRatio,
                                      child: VideoPlayer(videoController),
                                    )
                                  : Container(),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  videoController.value.isPlaying
                                      ? videoController.pause()
                                      : videoController.play();
                                });
                              },
                              child: Icon(
                                videoController.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                            ),
                          ],
                        )
                      : (questions[_cc]
                              .urlImageOrVideoQuestion
                              .contains("image"))
                          ? GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      contentPadding: EdgeInsets.zero,
                                      content: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: InteractiveViewer(
                                          boundaryMargin: EdgeInsets.all(0),
                                          minScale: 0.1,
                                          maxScale: 5.0,
                                          child: Image.network(
                                            questions[_cc]
                                                .urlImageOrVideoQuestion
                                                .split("]")[1],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FadeInImage(
                                    placeholder: const AssetImage(
                                        'assets/images/no-image.jpg'),
                                    image: NetworkImage(questions[_cc]
                                        .urlImageOrVideoQuestion
                                        .split("]")[1]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  widgetFeedback(List<UnitQuestion> questions) {
    return Column(
      children: [
        bodyWidgetFeedBack(questions),
        Card(
          child: OutlinedButton(
              onPressed: (() {
                setState(() {
                  _cc = _cc + 1;
                  _isShowingFeedback = false;
                });
              }),
              child: Text("Siguiente Ejercicio",
                  style: Theme.of(context).textTheme.headlineMedium)),
        ),
      ],
    );
  }

  Widget productCardWidget(List<Option> data, int index) {
    return data.isNotEmpty
        ? SizedBox(
            width: MediaQuery.of(context).size.width * 0.38,
            height: MediaQuery.of(context).size.width * 0.45,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Text(data[index].answerOption),
                  ),
                ],
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.40,
              height: MediaQuery.of(context).size.width * 0.59,
              child: const Stack(
                children: [
                  Align(
                      alignment: Alignment.center,
                      child: Text("No Hay Preguntas"))
                ],
              ),
            ),
          );
  }

  Widget viewNumberOfQuetion(String questionName) {
    return SizedBox(
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Text(
        "$questionName",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  _progressindicator(List<UnitQuestion> questions) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
        child: CircularCountDownTimer(
          duration: _counter,
          initialDuration: 0,
          controller: _controller,
          width: MediaQuery.of(context).size.width / 0.025,
          height: MediaQuery.of(context).size.height / 0.025,
          ringColor: Theme.of(context).focusColor,
          ringGradient: null,
          fillColor: Theme.of(context).primaryColor,
          fillGradient: null,
          backgroundColor: Theme.of(context).primaryColorLight,
          backgroundGradient: null,
          strokeWidth: 20.0,
          strokeCap: StrokeCap.round,
          textStyle: const TextStyle(
              fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: true,
          onStart: () {
            debugPrint('Countdown Started');
          },
          onComplete: () {
            if (_manyOption > 0) {
              //restartQuestion(questions);
            }
          },
          onChange: (String timeStamp) {
            score = int.parse(timeStamp);
          },
        ));
  }
}

showInCorrectAnswerWithMessage(BuildContext context, String message) {
  FToast fToast = FToast();
  fToast.init(context);

  (_manyOption > 0)
      ? fToast.showToast(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Card(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Respuesta Incorrecta\n Tienes  $_manyOption intentos mas",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image.asset(
                        'assets/images/thumnbdown.gif',
                        width: 100,
                        height: 100,
                        fit: BoxFit.contain,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          gravity: ToastGravity.CENTER,
        )
      : Container();
}

showCorrectAnswerWithMessage(BuildContext context, String message) {
  FToast fToast = FToast();
  fToast.init(context);

  fToast.showToast(
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Respuesta Correcta"),
                ),
                Image.asset(
                  'assets/images/thumnbup.gif',
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    gravity: ToastGravity.CENTER,
  );
}

class LinePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;
  final double strokeWidth;
  final double mostLeftSpot;

  LinePainter({
    required this.startPoint,
    required this.endPoint,
    required this.color,
    required this.strokeWidth,
    this.mostLeftSpot = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth;

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class Line {
  final Offset startPoint;
  final Offset endPoint;
  final Color color;
  final double strokeWidth;

  Line({
    required this.startPoint,
    required this.endPoint,
    required this.color,
    required this.strokeWidth,
  });
}
