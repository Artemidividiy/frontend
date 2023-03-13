import 'dart:math';

import 'package:colorful/core/auth/viewmodels/AuthViewModel.dart';

import 'package:colorful/enums/AuthMethod.dart';
import 'package:colorful/enums/ValidationStatus.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:flutter/material.dart';

import '../../home/views/HomeView.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _isLogInView = true;
  AuthViewModel vm = AuthViewModel();
  switchScreen() {
    setState(() {
      _isLogInView = !_isLogInView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: _isLogInView
                ? _LoginView(
                    switchView: switchScreen,
                    vm: vm,
                  )
                : _RegisterView(switchView: switchScreen, vm: vm)));
  }
}

class _LoginView extends StatefulWidget {
  final AuthViewModel vm;
  final Function switchView;
  _LoginView({
    Key? key,
    required this.switchView,
    required this.vm,
  }) : super(key: key);

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      key: formState,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              controller: _loginController,
              validator: emailValidator,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
              controller: _passwordController,
              validator: passwordValidator,
            ),
          ),
          TextButton(
            onPressed: () => widget.switchView(),
            child: Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.blue),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          ),
          TextButton(
              onPressed: () => authenticate(), child: Text("Authenticate"))
        ],
      ),
    ));
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "cannot be empty";
    if (!value.contains("@")) return "invalid email";
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "cannot be empty";
  }

  void authenticate() async {
    FocusManager.instance.primaryFocus?.unfocus();
    formState.currentState!.validate();
    var status = await widget.vm.validateUserData(
        _loginController.text, _passwordController.text, AuthMethod.Login);
    if (status == ValidationStatus.EmailNotFound)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email not found")));

    if (status == ValidationStatus.WrongPassword)
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Incorrect password")));
    else {
      widget.vm
          .authenticateUser(_loginController.text, _passwordController.text)
          .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeView())));
    }
  }
}

class _RegisterView extends StatefulWidget {
  final Function switchView;
  final AuthViewModel vm;
  const _RegisterView({super.key, required this.switchView, required this.vm});

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "cannot be empty";
    if (value.length < 8) return "too simple";
  }

  String? passwordConfirmationValidator(String? value) {
    if (value == null || value.isEmpty) return "cannot be empty";
    if (value != _passwordController.text) return "doesn't match";
    if (value.length < 8) return "too simple";
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return "cannot be empty";
    if (!value.contains("@")) return "invalid email";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  controller: _emailController,
                  validator: emailValidator,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: passwordValidator,
                  decoration: InputDecoration(hintText: "Password"),
                  obscureText: true,
                  controller: _passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: passwordConfirmationValidator,
                  decoration:
                      InputDecoration(hintText: "Password Confirmation"),
                  obscureText: true,
                  controller: _passwordConfirmationController,
                ),
              ),
              TextButton(
                onPressed: () => widget.switchView(),
                child: Text(
                  "Have an account?",
                  style: TextStyle(color: Colors.blue),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.transparent)),
              ),
              TextButton(onPressed: () => register(), child: Text("Register"))
            ],
          )),
    );
  }

  register() {
    if (formkey.currentState!.validate()) {
      widget.vm.registerNewUser(
          user: LocalUser(
              password: _passwordController.text,
              email: _emailController.text,
              uuid: <String>[RegExp(r'[a-z]').toString()].toString()));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeView(),
      ));
    }
  }
}
