import 'package:aritbook10/src/models/UnitModel/unit_model.dart';
import 'package:flutter/material.dart';

import '../widgets/ThemeSwipper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<UnitBook> unitOneBook;

  @override
  void initState() {
    // TODO: implement initState
    unitOneBook = [unit1Example(), unit2Example()];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ThemeSwipper(
                unitBooks: unitOneBook,
              ),
            ],
          ),
        ));
  }
}
