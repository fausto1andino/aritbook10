import 'dart:math';

import 'package:espe_math/src/models/UnitModel/unit_model.dart';
import 'package:espe_math/src/services/unit_content.services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool dataLoading = true;
  late FToast fToast;
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    getContent();
    super.initState();
  }

  void toastCorrect() {
    return fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.blue,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text("Datos Actualozados"),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: dataLoading
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
                        const Text("Cerrar sesión",
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
                        const Text("Nuevas clases?",
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
        const Duration(seconds: 25),
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
      mainProviderSave
          .updateUnitDataBase(unitOneBook)
          .whenComplete(() => toastCorrect());
      setState(() {
        dataLoading = false;
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
