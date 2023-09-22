// ignore_for_file: use_build_context_synchronously

import 'package:espe_math/src/services/shared_prefs.services.dart';
import 'package:espe_math/src/services/user.services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../core/Provider/main_provider.dart';
import '../models/user_data.model.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

class AuthServices {
  SharedPrefs sharedPrefs = SharedPrefs();
  FirebaseAuth auth = FirebaseAuth.instance;
  String verifId = "";
  UserServices userServices = UserServices();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      //'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  checkEmailAccounnt(String email, BuildContext context) async {
    var db = FirebaseFirestore.instance;
    final emailRef = db.collection("users");
    final query = emailRef.where("email", isEqualTo: email);
    final result = await query.get();
    if (result.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  signUpWithEmail(
      String email,
      String password,
      String name,
      String phonePrefix,
      String phoneNumber,
      String photoURL,
      BuildContext context) async {
    UserServices userServices = UserServices();
    try {
      var credential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      dev.log(credential.toString());
      UserData user = UserData(credential.user!.uid, name, email,
          Timestamp.now(), phonePrefix, false);
      userServices.createUser(user);
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<bool> loginWithEmail(
      String email, String password, BuildContext context) async {
    try {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);

      var credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      dev.log(credential.toString());

      mainProvider.updateToken(credential.user!.uid);

      Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) {
              return const MyHomePage(
                title: "Pagina Principal",
              );
            },
            transitionsBuilder: (c, anim, a2, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: anim.drive(tween),
                child: child,
              );
            },
          ),
          (route) => false);
      return true;
    } catch (e) {
      return false;
      //dev.log(e.toString());
    }
  }

  Future<bool> loginWithGoogle(BuildContext context) async {
    try {
      final mainProvider = Provider.of<MainProvider>(context, listen: false);

      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        return false;
      }

      // Aquí obtenemos las credenciales de Google
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Intenta autenticar al usuario con Firebase usando las credenciales de Google
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Si la autenticación es exitosa, actualizamos el token y navegamos a la página principal
        mainProvider.updateToken(userCredential.user!.uid);
        Navigator.of(context).pushAndRemoveUntil(
          PageRouteBuilder(
            pageBuilder: (context, a1, a2) =>
                const MyHomePage(title: "Pagina Principal"),
            transitionsBuilder: (c, anim, a2, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(position: anim.drive(tween), child: child);
            },
          ),
          (route) => false,
        );

        return true;
      }
    } catch (e) {
      dev.log(e.toString());

      if (e.toString().contains("sign_in_failed")) {
        dev.log("Error en el inicio de sesión o registro con Google.");
      } else if (e
          .toString()
          .contains("ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL")) {
        dev.log(
            "Una cuenta ya existe con un tipo de inicio de sesión diferente.");
      } else {
        // Puedes manejar más errores específicos de Firebase aquí si lo necesitas
      }
    }

    return false;
  }

  Future<void> googleCreateAccount(
      GoogleSignInAccount? googleSignInAccount, BuildContext context) async {
    final UserServices userServices = UserServices();

    var db = FirebaseFirestore.instance;
    final emailRef = db.collection("users");
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        final query = emailRef.where("email",
            isEqualTo: userCredential.user!.email.toString());
        final result = await query.get();
        //dev.log(userCredential.user!.email.toString());
        //dev.log("email" + result.docs[0].data().toString());

        if (result.docs.isNotEmpty) {
          dev.log("email existe en db");
        } else {
          dev.log("no email");
          //create user
          UserData user = UserData(
              userCredential.user!.uid,
              userCredential.user!.displayName.toString(),
              userCredential.user!.email.toString(),
              Timestamp.now(),
              userCredential.user!.photoURL.toString(),
              userCredential.user!.emailVerified);
          dev.log(user.email.toString());
          dev.log(user.toFirestore().toString());

          userServices.createUser(user);
        }
        await sharedPrefs.setUserID(userCredential.user!.uid);

        //if (!context.mounted) return;

        /*Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));*/
      } catch (e) {
        dev.log(e.toString());
      }
    }
  }

  logoutGoogle() async {
    sharedPrefs.setUserID("");
    await _googleSignIn.signOut();
  }

  signOut(context) async {
    await sharedPrefs.setUserID("");
    await auth.signOut();
    await _googleSignIn.signOut();
    dev.log("logout");

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  Future<bool> checkPhoneVerification(context) async {
    dev.log(auth.currentUser!.phoneNumber.toString());
    if (auth.currentUser!.phoneNumber != null) {
      await sharedPrefs.setPhoneVerified(true);
      return true;
    } else {
      dev.log("no phone");
      await sharedPrefs.setPhoneVerified(false);
      /*Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PhoneVerification(
                    newUser: true,
                  )));*/
      return false;
    }
  }

  sendConfirmationSMS(String phoneNumber, BuildContext context) async {
    dev.log("send sms");
    dev.log(phoneNumber.toString());
    try {
      auth.verifyPhoneNumber(
        phoneNumber: "+$phoneNumber",
        verificationCompleted: (PhoneAuthCredential credential) async {
          dev.log("verif completed");
          dev.log(credential.smsCode.toString());
          dev.log(credential.token.toString());
          var data =
              await FirebaseAuth.instance.signInWithCredential(credential);
          dev.log(data.toString());
        },
        verificationFailed: (FirebaseAuthException e) {
          dev.log("verif failed");
          dev.log(e.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          dev.log("code sent");
          verifId = verificationId;
          dev.log(verificationId.toString());
          dev.log(resendToken.toString());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          dev.log("Timeout");
          dev.log("Timeout $verificationId");
        },
      );
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<bool> submitOTP(String otp, BuildContext context) async {
    dev.log("submit otp");

    try {
      PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(verificationId: verifId, smsCode: otp);
      dev.log(phoneAuthCredential.toString());

      await auth.currentUser?.updatePhoneNumber(phoneAuthCredential);

      await userServices.updateUserPhoneNumber(
          auth.currentUser!.uid, auth.currentUser!.phoneNumber.toString());
      dev.log("SubmitOTP valid");
      /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );*/
      return true;
    } catch (e) {
      dev.log(e.toString());
      return false;
    }
  }
}
