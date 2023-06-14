import 'package:aritbook10/src/models/UnitModel/unit_model.dart';
import 'package:aritbook10/src/services/unit_content.services.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import '../services/auth.services.dart';
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
    getContent();
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
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: IconButton(
                      tooltip: "Cerrar sesión",
                      onPressed: () {
                        logOut();
                      },
                      icon: Icon(Icons.logout_outlined),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 200,
                    child: IconButton(
                      tooltip: "Datos",
                      onPressed: () {
                        getContent();
                      },
                      icon: Icon(Icons.dataset),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  getContent() {
    UnitContent unitContent = UnitContent();
    unitContent.getContent();
  }

  logOut() {
    AuthServices authServices = AuthServices();
    dev.log("LOGOUT");
    authServices.signOut(context);
  }
}
