import 'dart:math';

import 'package:EspeMath/src/models/UnitModel/unit_model.dart';
import 'package:EspeMath/src/services/unit_content.services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;
import '../core/Provider/main_provider.dart';
import '../services/auth.services.dart';
import '../widgets/ThemeSwipper.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<UnitBook> unitOneBook = [];
  bool data_loading = true;
  @override
  void initState() {
    // TODO: implement initState
    getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: data_loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ThemeSwipper(
                      unitBooks: unitOneBook,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            tooltip: "Cerrar sesión",
                            onPressed: () {
                              logOut();
                            },
                            icon: const Icon(Icons.logout_outlined),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Cerrar sesión",
                            style: TextStyle(color: Colors.red)),
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: IconButton(
                            tooltip: "Datos",
                            onPressed: () {
                              getContent();
                            },
                            icon: const Icon(Icons.dataset),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("Nuevas clases?",
                            style: TextStyle(color: Colors.blue)),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    )
                  ],
                ),
              ));
  }

  getContent() async {
    final mainProviderSave = Provider.of<MainProvider>(context, listen: false);
    UnitContent unitContent = UnitContent();
    dev.log("HOMESCREEN");
    unitOneBook.clear();

    try {
      List<UnitBook>? data = await unitContent.getContent().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          dev.log(e.toString());
          mainProviderSave.getPreferencesUnitDataBase().then((value) {
            setState(() {
              unitOneBook = value;
            });
          });
          return unitOneBook;
        },
      );
      for (var item in data) {
        unitOneBook.add(item);
      }
      mainProviderSave.updateUnitDataBase(unitOneBook);
      setState(() {
        data_loading = false;
      });
    } on Exception catch (e) {
      dev.log(e.toString());
      mainProviderSave.getPreferencesUnitDataBase().then((value) {
        setState(() {
          unitOneBook = value;
        });
      });
    }
  }

  logOut() {
    AuthServices authServices = AuthServices();
    dev.log("LOGOUT");
    authServices.signOut(context);
  }
}
