import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sign_in_button/sign_in_button.dart';
import 'dart:developer' as dev;
import 'package:fluttertoast/fluttertoast.dart';
import '../bloc/login_bloc.dart';
import '../core/Provider/main_provider.dart';
import '../services/auth.services.dart';
import '../widgets/toast.widget.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool buttonGoogle = true;
final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  //controlador de las validaciones
  late LoginBloc bloc;
  late FToast fToast;

  //controlador para ocultar la contraseña
  bool _obscureText = true;

  //Inicializacion de las variables
  @override
  void initState() {
    bloc = LoginBloc();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              //background
              image: AssetImage("assets/images/loginbackground.png"),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      //logo de eras
                      image: AssetImage("assets/images/LogoAritbook.png"),
                      fit: BoxFit.fill),
                ),
                child: const SizedBox(
                  height: 110,
                  width: double.infinity,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                      child: Center(
                          child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                          color: Theme.of(context).hintColor, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: SizedBox(
                        width: size.width * 0.8,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                      controller: _nameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(Icons.email,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                          hintText: 'nombre del estudiante',
                                          labelText: 'Nombre de Usuario')),
                                ),
                                StreamBuilder(
                                    //controlador de contraseña
                                    stream: bloc.passwordStream,
                                    builder: (BuildContext context,
                                            AsyncSnapshot snapshot) =>
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                              controller: _passwordController,
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              onChanged: bloc.changePassword,
                                              obscureText: _obscureText,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      _obscureText =
                                                          !_obscureText;
                                                      setState(() {});
                                                    },
                                                    icon: _obscureText
                                                        ? Icon(
                                                            Icons
                                                                .visibility_off,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark)
                                                        : Icon(Icons.visibility,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColorDark)),
                                                errorText:
                                                    snapshot.error?.toString(),
                                                icon: Icon(
                                                  Icons.lock_outline,
                                                  color: Theme.of(context)
                                                      .primaryColorDark,
                                                ),
                                                labelText: 'Contraseña',
                                              )),
                                        )),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SignInButton(
                                      Buttons.google,
                                      elevation: 2.0,
                                      text: 'Iniciar con Google',
                                      onPressed: () async {
                                        if (buttonGoogle) {
                                          buttonGoogle = false;
                                          var result = googleSignIn(context);
                                          buttonGoogle = true;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("Olvidé mi Contraseña",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColorLight))),
                                  ],
                                )
                              ],
                             ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: SizedBox(
                                  height: 45,
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  )))),
                                      onPressed: () async {
                                        onClickLogin();
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.login),
                                      label: const Text("Ingresar")),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ))),
                ),
              ],
            ),
          ]),
        ),
      )),
    );
  }

  onClickLogin() {
    // Store user logged in
    final mainProvider = Provider.of<MainProvider>(context, listen: false);

    mainProvider.updateToken(_nameController.text);

    // Show Main screen

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
  }

  googleSignIn(context) async {
    AuthServices auth = AuthServices();
    bool toast = await auth.loginWithGoogle(context).then((value) {
      dev.log(value.toString());
      dev.log("Valor de toast");
      return value;
    });
    toast ? ToastCorrect() : ToastError("No se pudo iniciar sesión");
  }

  void ToastCorrect() {
    return fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.greenAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text("Inicio de sesión exitoso"),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void ToastError(String errorMessage) {
    return fToast.showToast(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.redAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error),
            SizedBox(
              width: 12.0,
            ),
            Text(errorMessage),
          ],
        ),
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }
}
