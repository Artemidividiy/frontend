import 'package:colorful/core/auth/views/AuthView.dart';
import 'package:colorful/core/entry/views/decide_page.dart';
import 'package:colorful/enums/AuthStatus.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:flutter/material.dart';
import '../viewmodels/AuthViewModel.dart';

class SplashView extends StatelessWidget {
  final AuthViewModel vm = AuthViewModel();
  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<LocalUser?>(
          future: vm.user,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null)
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DecidePage(),
              ));
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null)
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AuthView(),
              ));
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
