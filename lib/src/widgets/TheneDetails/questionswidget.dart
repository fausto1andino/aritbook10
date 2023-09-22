import 'dart:async';
import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import '../../models/UnitModel/unitoption_model.dart';
import '../../pages/home_page.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

Timer? countdownTimer;

int _counter = 31;
int _cc = 0;
int score = 0;
int _manyOption = 3;

bool _answerSended1 = false;
bool _answerSended2 = false;
bool _answerSended3 = false;
bool _answerSended4 = false;

String _textanswerSended1 = "openAngle";
String _textanswerSended2 = "openAngle";
String _textanswerSended3 = "";
String _textanswerSended4 = "";

enum TypeAngleX { openAngle, closedAngle }

enum TypeAngleY { openAngle, closedAngle }

late int scoreShow;

late CountDownController _controller;

class _QuestionWidgetState extends State<QuestionWidget> {
  TypeAngleX _typeAnlgeX = TypeAngleX.openAngle;
  TypeAngleY _typeAnlgeY = TypeAngleY.openAngle;
  @override
  void initState() {
    super.initState();
    _controller = CountDownController();
    scoreShow = 0;
  }

  @override
  void dispose() {

    super.dispose();
    score = 0;
    scoreShow = 0;
    _cc = 0;
    _counter = 31;
    _answerSended1 = false;
    _answerSended2 = false;
    _answerSended3 = false;
    _answerSended4 = false;
    _manyOption = 3;
  }

  @override
  Widget build(BuildContext context) {
    final List<UnitQuestion> unitQuestion =
        ModalRoute.of(context)!.settings.arguments as List<UnitQuestion>;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: (unitQuestion.length > _cc)
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05,
                          ),
                          child: _progressindicator(unitQuestion),
                        ),
                        (_cc == 0)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    child: straightEquations(0, unitQuestion)),
                              )
                            : (_cc == 1)
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
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      child: PageView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return SingleChildScrollView(
                                              child: _questionsWidget(
                                                  index, unitQuestion),
                                            );
                                          }),
                                    ),
                                  ),
                      ],
                    )
                  : Center(child: _bodyEndQuestionQ()),
            )
          ],
        ),
      ),
    );
  }

  ///
  /// Ejericio de Graficar una Recta en X
  ///

  String _equationX = "";
  String _equationY = "";
  List<FlSpot> _data = [];
  bool _isGraphed = false;

  void _generateLineData() {
    if (_equationX.isEmpty || _equationY.isEmpty) {
      return;
    }
    _isGraphed = true;
    final double x1 = double.parse(_equationX);
    final double x2 = double.parse(_equationY);

    final List<FlSpot> data = [
      FlSpot(x1, 0),
      FlSpot(x2, 0),
    ];

    setState(() {
      _data = data;
    });
  }

  Widget straightEquations(int index, List<UnitQuestion> questions) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: viewNumberOfQuetion(questions[_cc].titleQuestion),
      ),
      Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.1),
              child: Text((_textanswerSended1 == "openAngle") ? "( " : "[ ",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  _equationX = value.trim();
                  _textanswerSended3 = _equationX;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.1),
              child: Text(" , ",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: '',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  _equationY = value.trim();
                  _textanswerSended4 = _equationY;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.1),
              child: Text((_textanswerSended2 == "openAngle") ? " )" : " ]",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.black)),
            ),
          ],
        ),
      ),
      Padding(
        padding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.15),
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Radio<TypeAngleY>(
                      value: TypeAngleY.openAngle,
                      groupValue: _typeAnlgeY,
                      onChanged: (TypeAngleY? value) {
                        setState(() {
                          _typeAnlgeY = value!;
                          _textanswerSended1 = value.toString().split('.').last;
                          log(_textanswerSended1);
                        });
                      },
                    ),
                    Text(' ( - X ) Abierto',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    Radio<TypeAngleY>(
                      value: TypeAngleY.closedAngle,
                      groupValue: _typeAnlgeY,
                      onChanged: (TypeAngleY? value) {
                        setState(() {
                          _typeAnlgeY = value!;
                          _textanswerSended1 = value.toString().split('.').last;
                          log(_textanswerSended1);
                        });
                      },
                    ),
                    Text(' ( - X ) Cerrado',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black)),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Radio<TypeAngleX>(
                      value: TypeAngleX.openAngle,
                      groupValue: _typeAnlgeX,
                      onChanged: (TypeAngleX? value) {
                        setState(() {
                          _typeAnlgeX = value!;
                          _textanswerSended2 = value.toString().split('.').last;
                          log(_textanswerSended2);
                        });
                      },
                    ),
                    Text(' ( + X ) Abierto',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    Radio<TypeAngleX>(
                      value: TypeAngleX.closedAngle,
                      groupValue: _typeAnlgeX,
                      onChanged: (TypeAngleX? value) {
                        setState(() {
                          _typeAnlgeX = value!;
                          _textanswerSended2 = value.toString().split('.').last;
                          log(_textanswerSended2);
                        });
                      },
                    ),
                    Text(' ( + X ) Cerrado',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.black)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          child: OutlinedButton(
              onPressed: () {
                _generateLineData();
              },
              child: const Text("Graficar"))),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              maxX: 10,
              minX: -10,
              maxY: 10,
              minY: -10,
              lineTouchData: const LineTouchData(
                enabled: false,
              ),
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
                  spots: _data,
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
      SizedBox(
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.1,
          child: OutlinedButton(
              onPressed: () {
                if (_isGraphed) {
                  sendStraightEquationAnswer(questions, index);
                } else {
                  showSnackbarWithMessage(context, "Grafique su respuesta");
                }
              },
              child: const Text("Responder"))),
    ]);
  }

  ///
  /// Ejericio de Graficar una Recta con 2 Puntos
  ///

  String _equation2P1X = "";
  String _equation2P1Y = "";
  String _equation2P2X = "";
  String _equation2P2Y = "";

  List<FlSpot> _data2P = [];

  void _generateLine2PointsData() {
    _isGraphed = true;
    if (_equation2P1X.isEmpty ||
        _equation2P1Y.isEmpty ||
        _equation2P2X.isEmpty ||
        _equation2P2Y.isEmpty) {
      return;
    }

    final double x1 = double.parse(_equation2P1X);
    final double y1 = double.parse(_equation2P1Y);
    final double x2 = double.parse(_equation2P2X);
    final double y2 = double.parse(_equation2P2Y);

    final List<FlSpot> data = [
      FlSpot(x1, y1),
      FlSpot(x2, y2),
    ];

    setState(() {
      _data2P = data;
    });
  }

  Widget linearEquations2Points(int index, List<UnitQuestion> questions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: viewNumberOfQuetion(questions[_cc].titleQuestion),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text("( ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Punto 1 X',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        _equation2P1X = value.trim();
                        _textanswerSended1 = _equation2P1X;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text(" , ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Punto 1 Y',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        _equation2P1Y = value.trim();
                        _textanswerSended2 = _equation2P1Y;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text(" )",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text("( ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Punto 2 X',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        _equation2P2X = value.trim();
                        _textanswerSended3 = _equation2P2X;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text(" , ",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.width * 0.25,
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Punto 2 Y',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      setState(() {
                        _equation2P2Y = value.trim();
                        _textanswerSended4 = _equation2P2Y;
                      });
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width * 0.1),
                child: Text(" )",
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black)),
              ),
            ],
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            child: OutlinedButton(
                onPressed: () {
                  _generateLine2PointsData();
                },
                child: const Text("Graficar"))),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                lineTouchData: const LineTouchData(enabled: false),
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
                ),
                borderData: FlBorderData(
                  show: true,
                  border: const Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                    left: BorderSide(color: Colors.grey, width: 0.5),
                    right: BorderSide(color: Colors.transparent),
                    top: BorderSide(color: Colors.transparent),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: _data2P,
                    isCurved: false,
                    color: Colors.blue,
                    barWidth: 2.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
            height: MediaQuery.of(context).size.width * 0.1,
            width: MediaQuery.of(context).size.width * 0.1,
            child: OutlinedButton(
                onPressed: () {
                  if (_isGraphed) {
                    sendStraightEquationAnswer(questions, index);
                  } else {
                    showSnackbarWithMessage(context, "Grafique su respuesta");
                  }
                },
                child: const Text("Responder"))),
      ],
    );
  }

  ///
  /// Trivia
  ///

  _questionsWidget(int index, List<UnitQuestion> questions) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: viewNumberOfQuetion(questions[_cc].titleQuestion),
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
                  _answerSended1 = true;
                  _textanswerSended1 = "1";
                });
              },
              child: Card(
                color: (_answerSended1 || _textanswerSended1 == "1")
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).indicatorColor,
                child: productCard(questions, index * 4),
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
                color: (_answerSended2 || _textanswerSended2 == "1")
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).indicatorColor,
                child: productCard(questions, index * 4 + 1),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            top: MediaQuery.of(context).size.height * 0.01),
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
                color: (_answerSended3 || _textanswerSended3 == "1")
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).indicatorColor,
                child: productCard(questions, index * 4 + 2),
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
                color: (_answerSended4 || _textanswerSended4 == "1")
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).indicatorColor,
                child: productCard(questions, index * 4 + 3),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  void restartQuestion(List<UnitQuestion> data) {
    _cc = _cc + 1;
    _manyOption = 3;

    score = 0;

    _answerSended1 = false;
    _answerSended2 = false;
    _answerSended3 = false;
    _answerSended4 = false;

    _equationX = "";
    _equationY = "";

    _equation2P1X = "";
    _equation2P2X = "";
    _equation2P1Y = "";
    _equation2P2Y = "";

    _data = [];
    _data2P = [];
    _isGraphed = false;
    _counter = 31;

    if (data.length > _cc) {
      Timer(const Duration(milliseconds: 31), () {
        if (mounted) {
          _controller.restart(duration: _counter);
        }
      });
    }
  }

  void sendStraightEquationAnswer(List<UnitQuestion> data, int index) {
    _controller.pause();
    _counter = 31;
    if (_manyOption > 0) {
      if (data[_cc].option[0].answerOption == _textanswerSended1 &&
          data[_cc].option[1].answerOption == _textanswerSended2 &&
          data[_cc].option[2].answerOption == _textanswerSended3 &&
          data[_cc].option[3].answerOption == _textanswerSended4) {
        _manyOption = _manyOption - 3;
        log("Se pulsado el boton $index");
        setState(() {
          _answerSended1 = data[_cc].option[0].isTheCorrectOption;
          _answerSended2 = data[_cc].option[1].isTheCorrectOption;
          _answerSended3 = data[_cc].option[2].isTheCorrectOption;
          _answerSended4 = data[_cc].option[3].isTheCorrectOption;
          scoreShow = scoreShow + score;
          restartQuestion(data);
          showSnackbarWithMessage(context, "Respuesta Correcta");
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

        showSnackbarWithMessage(context, "Respuesta Incorrecta");
      }
    }
  }

  Widget productCard(List<UnitQuestion> data, int index) {
    return index < data.length
        ? GestureDetector(
            onTap: () {
              _controller.pause();
              _counter = 31;
              if (_manyOption > 0) {
                if (data[_cc].option[index].isTheCorrectOption) {
                  _manyOption = _manyOption - 3;
                  log("Se pulsado el boton $index");
                  setState(() {
                    _answerSended1 = data[_cc].option[0].isTheCorrectOption;
                    _answerSended2 = data[_cc].option[1].isTheCorrectOption;
                    _answerSended3 = data[_cc].option[2].isTheCorrectOption;
                    _answerSended4 = data[_cc].option[3].isTheCorrectOption;
                    scoreShow = scoreShow + score;
                    restartQuestion(data);
                    showSnackbarWithMessage(context, "Respuesta Correcta");
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
                    _cc = _cc + 1;
                    restartQuestion(data);
                  });

                  showSnackbarWithMessage(context, "Respuesta Incorrecta");
                }
              }
            },
            child: Column(
              children: [
                productCardWidget(data, index),
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.all(0),
          );
  }

  _bodyEndQuestion() {
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
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center),
                        Text("$scoreShow",
                            style: Theme.of(context).textTheme.displaySmall,
                            textAlign: TextAlign.center)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _bodyEndQuestionQ() {
    return Column(
      children: [
        _bodyEndQuestion(),
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

  Widget productCardWidget(List<UnitQuestion> data, int index) {
    return index < data.length
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
                    child: Text((index == 0)
                        ? data[_cc].option[0].answerOption
                        : (index == 1)
                            ? data[_cc].option[1].answerOption
                            : (index == 2)
                                ? data[_cc].option[2].answerOption
                                : (index == 3)
                                    ? data[_cc].option[3].answerOption
                                    : data[_cc].option[0].answerOption),
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
        questionName,
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

showSnackbarWithMessage(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
