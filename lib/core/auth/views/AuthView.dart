import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _isLogInView = true;
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
                  )
                : _RegisterView(
                    switchView: switchScreen,
                  )));
  }
}

class _LoginView extends StatefulWidget {
  final Function switchView;
  _LoginView({
    Key? key,
    required this.switchView,
  }) : super(key: key);

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Login"),
              controller: _loginController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
              controller: _passwordController,
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
          TextButton(onPressed: () => null, child: Text("Authenticate"))
        ],
      ),
    ));
  }
}

class _RegisterView extends StatefulWidget {
  final Function switchView;
  const _RegisterView({super.key, required this.switchView});

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
  String? validate() {}
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) return "cannot be empty";
    if (value.length < 8) return "too simple";
  }

  String? passwordConfirmationValidator(String? value) {
    if (value == null || value.isEmpty) return "cannot be empty";
    if (value != _passwordController.text) return "doesn't match";
    if (value.length < 8) return "too simple";
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
                  obscureText: true,
                  controller: _emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(hintText: "Login"),
                  controller: _loginController,
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
    formkey.currentState!.validate();
  }
}
