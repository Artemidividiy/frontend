import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'package:colorful/core/auth/viewmodels/AuthViewModel.dart';
import 'package:colorful/core/entry/views/decide_page.dart';
import 'package:colorful/models/LocalUser.dart';

class SupaAuthView extends StatefulWidget {
  AuthViewModel vm;
  SupaAuthView({
    Key? key,
    required this.vm,
  }) : super(key: key);

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

  void push(AuthResponse response, BuildContext context) async {
    LocalUser.instance = LocalUser(
        email: response.user!.email!, password: null, uuid: response.user!.id);
    await widget.vm.registerNewUser(user: LocalUser.instance!);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => DecidePage()));
  }
}
