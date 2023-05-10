import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../widgets/ThemeSwipper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _equation;
  List<FlSpot> _data = [];

  void _generateLineData() {
    if (_equation == null) {
      return;
    }
    final RegExp regex = RegExp(r'^y\s*=\s*(-?\d+)\s*x\s*\+\s*(-?\d+)$');
    final Match? match = regex.firstMatch(_equation!);
    if (match == null) {
      return;
    }
    final double slope = double.parse(match.group(1)!);
    final double yIntercept = double.parse(match.group(2)!);

    final List<FlSpot> data = [];
    for (double x = -10; x <= 10; x++) {
      final double y = slope * x + yIntercept;
      if (y >= -10 && y <= 10) {
        data.add(FlSpot(x, y));
      }
    }

    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [ThemeSwipper()],
        ));
  }

  Widget LinearEquations() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Ingrese una ecuación de la forma "y = mx + b"',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) {
            setState(() {
              _equation = value.trim();
              _generateLineData();
            });
          },
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LineChart(
            LineChartData(
              maxX: 10,
              minX: -10,
              maxY: 10,
              minY: -10,
              lineTouchData: LineTouchData(enabled: false),
              gridData: FlGridData(
                show: true,
                getDrawingHorizontalLine: (value) {
                  if (value == 0) {
                    return FlLine(
                      color: Colors.blue,
                      strokeWidth: 2.0,
                    );
                  } else {
                    return FlLine(
                      color: Colors.grey,
                      strokeWidth: 0.5,
                    );
                  }
                },
                getDrawingVerticalLine: (value) {
                  if (value == 0) {
                    return FlLine(
                      color: Colors.blue,
                      strokeWidth: 2.0,
                    );
                  } else {
                    return FlLine(
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
                  spots: _data,
                  isCurved: false,
                  color: Colors.blue,
                  barWidth: 2.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
