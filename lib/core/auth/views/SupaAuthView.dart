import 'package:colorful/core/entry/views/decide_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class SupaAuthView extends StatefulWidget {
  const SupaAuthView({super.key});

  @override
  State<SupaAuthView> createState() => _SupaAuthViewState();
}

class _SupaAuthViewState extends State<SupaAuthView> {
  bool isLogIn = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 80.0, left: 8, right: 8),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        SupaEmailAuth(
            authAction: isLogIn ? SupaAuthAction.signIn : SupaAuthAction.signUp,
            onSuccess: (res) => push(res, context)),
        TextButton(
            onPressed: () => setState(() {
                  isLogIn = !isLogIn;
                }),
            child: Text(
                isLogIn ? "Don't have an account" : "Already have an account?"))
      ]),
    ));
  }

  void push(AuthResponse response, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DecidePage()));
  }
}
