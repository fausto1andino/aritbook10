import 'dart:convert';
import 'dart:developer';

import 'package:EspeMath/src/models/UnitModel/unit_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainProvider extends ChangeNotifier {
  static late SharedPreferences prefs;

  ///
  ///Login Automatico
  ///

  String _token = "";

  String get token {
    return _token;
  }

  set token(String newToken) {
    updateToken(newToken);
    _token = newToken;
    notifyListeners();
  }

  Future<void> updateToken(String token) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
  }

  Future<String> getPreferencesToken() async {
    try {
      prefs = await SharedPreferences.getInstance();
      _token = prefs.getString("token") ?? "";
      return _token;
    } catch (e) {
      return "";
    }
  }

  ///
  ///Login Automatico
  ///

  String _unitDataBase = "";

  UnitBook unitToGet = UnitBook(
      idUnitBook: "",
      titleUnitBook: "",
      urlMainImage: "",
      descriptionUnitBook: "",
      unitSubject: [],
      unitQuestion: []);

  String get unitDataBase {
    return _unitDataBase;
  }

  set unitDataBase(String newUnitDataBase) {
    updateToken(newUnitDataBase);
    _unitDataBase = newUnitDataBase;
    notifyListeners();
  }

  Future<void> updateUnitDataBase(
      List<UnitBook> unitToGets) async {
    prefs = await SharedPreferences.getInstance();
    var jsonUnitToGets = jsonEncode(unitToGets);
    log("los datos de la unidad guardados son : $jsonUnitToGets");
    await prefs.setString("unitDataBase", jsonUnitToGets);
  }

Future<List<UnitBook>> getPreferencesUnitDataBase() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String unitDataBase = prefs.getString("unitDataBase") ?? "";

      if (unitDataBase.isNotEmpty) {
        var jsonDataBase = jsonDecode(unitDataBase);
        if (jsonDataBase is List) {
          return jsonDataBase.map((data) => UnitBook.fromJson(data)).toList();
        }
      }

      return []; // Devuelve una lista vacía si no hay datos almacenados.
    } catch (e) {
      log("Error al obtener datos: $e");
      return []; // Devuelve una lista vacía en caso de error.
    }
  }
}
