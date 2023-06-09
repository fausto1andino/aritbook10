// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAdiYEpjASgd3vlzY_YZrbyePJeX8U6VvY',
    appId: '1:385796186485:web:8e6f5854325b46749db33c',
    messagingSenderId: '385796186485',
    projectId: 'matbook-93511',
    authDomain: 'matbook-93511.firebaseapp.com',
    storageBucket: 'matbook-93511.appspot.com',
    measurementId: 'G-ZCKBWBF9HP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyASF-2-vcXOVoEiUL7_0QuXVCZBkICSlKU',
    appId: '1:385796186485:android:82cfbfed6a3ff07f9db33c',
    messagingSenderId: '385796186485',
    projectId: 'matbook-93511',
    storageBucket: 'matbook-93511.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYu50vfIQYGd6cwkN93Ogj4z1W3gi5gpM',
    appId: '1:385796186485:ios:bfb243f91746a27f9db33c',
    messagingSenderId: '385796186485',
    projectId: 'matbook-93511',
    storageBucket: 'matbook-93511.appspot.com',
    iosClientId:
        '385796186485-krclp969npc0dpq5h1gafu6n9h02959d.apps.googleusercontent.com',
    iosBundleId: 'com.example.EspeMath',
  );
}
