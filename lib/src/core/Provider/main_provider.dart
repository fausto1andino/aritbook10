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
  ///FCMTOKEN
  ///


  String _fcmToken = "";

  String get fcmToken {
    return _fcmToken;
  }

  set fcmToken(String newFcmToken) {
    updateFcmToken(newFcmToken);
    _fcmToken = newFcmToken;
    notifyListeners();
  }

  Future<void> updateFcmToken(String fcmToken) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setString("fcmtoken", fcmToken);
  }

  Future<String> getPreferencesfcmToken() async {
    try {
      prefs = await SharedPreferences.getInstance();
      _fcmToken = prefs.getString("fcmtoken") ?? "";
      return _fcmToken;
    } catch (e) {
      return "";
    }
  }


  ///
  ///Latitud
  ///

  double _latitude = 0;

  double get latitude {
    return _latitude;
  }

  set latitude(double newLatitude) {
    updateLatitude(newLatitude);
    _latitude = newLatitude;
    notifyListeners();
  }

  Future<void> updateLatitude(double latitude) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("latitude", latitude);
  }

  Future<double> getPreferencesLatitude() async {
    try {
      prefs = await SharedPreferences.getInstance();
      _latitude = prefs.getDouble("latitude") ?? 0;
      return _latitude;
    } catch (e) {
      return 0;
    }
  }

  ///
  ///Longitud
  ///

  double _longitude = 0;

  double get longitude {
    return _longitude;
  }

  set longitude(double newLongitude) {
    updateLongitude(newLongitude);
    _longitude = newLongitude;
    notifyListeners();
  }

  Future<void> updateLongitude(double longitude) async {
    prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("longitude", longitude);
  }

  Future<double> getPreferencesLongitude() async {
    try {
      prefs = await SharedPreferences.getInstance();
      _longitude = prefs.getDouble("longitude") ?? 0;
      return _longitude;
    } catch (e) {
      return 0;
    }
  }
}
