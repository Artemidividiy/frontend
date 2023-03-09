import 'package:colorful/core/user/viewmodels/UserViewModel.dart';
import 'package:flutter/material.dart';
import '../../../models/ColorScheme.dart' as cs;
import '../../../models/LocalUser.dart';

class UserView extends StatefulWidget {
  final UserViewModel vm = UserViewModel();
  UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    widget.vm.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(LocalUser.instance!.email),
              Text(LocalUser.instance!.id!.toString()),
              FutureBuilder<List<cs.ColorScheme>>(
                future: widget.vm.liked_schemes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData)
                    return Column(
                      children: List.generate(
                          snapshot.data!.length,
                          (iIndex) => Container(
                                child: Row(
                                    children: List.generate(
                                        snapshot.data![iIndex].colorCount,
                                        (jIndex) => Container(
                                              color: snapshot.data![iIndex]
                                                  .colors[jIndex].color,
                                              child: Text(snapshot.data![iIndex]
                                                  .colors[jIndex].name),
                                            ))),
                              )),
                    );
                  return CircularProgressIndicator();
                },
              ),
              TextButton.icon(
                  onPressed: () => widget.vm.logout(context),
                  icon: Icon(Icons.logout),
                  label: Text("Log out")),
            ],
          ),
        ),
      ),
    );
  }
}
