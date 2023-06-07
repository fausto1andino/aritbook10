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

final TextEditingController _nameController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  //controlador de las validaciones
  late LoginBloc bloc;
  Toasty toast = Toasty();
  bool buttonGoogle = true;

  //controlador para ocultar la contraseña
  bool _obscureText = true;
  late FToast fToast;

  //Inicializacion de las variables
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    bloc = LoginBloc();
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
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 35),
                                  child: TextField(
                                      controller: _nameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          icon: Icon(Icons.email,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                          hintText: 'Ingresa tu correo',
                                          labelText: 'Correo electrónico')),
                                ),
                                StreamBuilder(
                                    //controlador de contraseña
                                    stream: bloc.passwordStream,
                                    builder: (BuildContext context,
                                            AsyncSnapshot snapshot) =>
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 35),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: Text("Olvide mi Contraseña",
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 16),
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
                                        loginWithEmail();
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.login),
                                      label: const Text("Ingresar")),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35),
                              child: SizedBox(
                                width: size.width * 0.8,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: SignInButton(
                                    Buttons.google,
                                    elevation: 8.0,
                                    text: 'Iniciar con Google',
                                    onPressed: () async {
                                      if (buttonGoogle) {
                                        buttonGoogle = false;
                                        dev.log("Iniciar sesión");
                                        var result = googleSignIn(context);
                                        buttonGoogle = true;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            //const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 35.0),
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
                                                        .secondaryHeaderColor,
                                                  )))),
                                      onPressed: () async {
                                        loginWithEmail();
                                        setState(() {});
                                      },
                                      icon: const Icon(Icons.person_add),
                                      label: const Text("Registrate")),
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

  loginWithEmail() async {
    dev.log('Login');
    // Store user logged in
    AuthServices auth = AuthServices();

    bool success = await auth
        .loginWithEmail(_nameController.text, _passwordController.text, context)
        .then((value) {
      dev.log(value.toString());
      value
          ? toast.ToastCorrect('Inicio de sesión exitoso')
          : toast.ToastError("Revisa tu correo y contraseña");
      dev.log("Valor de toast");
      return value;
    });
    success
        ? toast.ToastCorrect('Inicio de sesión exitoso')
        : toast.ToastError("Revisa tu correo y contraseña");
  }

  googleSignIn(context) async {
    AuthServices auth = AuthServices();
    bool success = await auth.loginWithGoogle(context).then((value) {
      dev.log(value.toString());
      dev.log("Valor de toast");
      return value;
    });

    await context;
    success
        ? toast.ToastCorrect('Inicio de sesión exitoso')
        : toast.ToastError("No se pudo iniciar sesión");
  }
}
