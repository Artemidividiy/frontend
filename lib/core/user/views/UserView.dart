import 'package:colorful/core/user/viewmodels/UserViewModel.dart';
import 'package:flutter/material.dart';

class UserView extends StatefulWidget {
  final UserViewModel vm = UserViewModel();
  UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
            onPressed: () => widget.vm.logout(context),
            icon: Icon(Icons.logout),
            label: Text("Log out")),
      ),
    );
  }
}
