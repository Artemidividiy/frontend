import 'package:colorful/core/home/views/ExportSchemeView.dart';
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
              Text("Email: ${LocalUser.instance!.email}"),
              FutureBuilder<List<cs.ColorScheme>>(
                future: widget.vm.liked_schemes,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData)
                    // ignore: curly_braces_in_flow_control_structures
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                          snapshot.data!.length,
                          (iIndex) => GestureDetector(
                                onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    UserViewModel.currentScheme =
                                        snapshot.data![iIndex];
                                    return _Preferences(
                                      scheme: snapshot.data![iIndex],
                                      vm: widget.vm,
                                    );
                                  },
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Wrap(
                                      children: List.generate(
                                          snapshot.data![iIndex].colorCount,
                                          (jIndex) => Container(
                                                margin: const EdgeInsets.all(4),
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                    color: snapshot
                                                        .data![iIndex]
                                                        .colors[jIndex]
                                                        .color,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                child: Text(
                                                  snapshot.data![iIndex]
                                                      .colors[jIndex].name,
                                                  style: TextStyle(
                                                      color: ThemeData.estimateBrightnessForColor(
                                                                  snapshot
                                                                      .data![
                                                                          iIndex]
                                                                      .colors[
                                                                          jIndex]
                                                                      .color) ==
                                                              Brightness.light
                                                          ? Colors.black
                                                          : Colors.white),
                                                ),
                                              ))),
                                ),
                              )),
                    );
                  return const CircularProgressIndicator();
                },
              ),
              TextButton.icon(
                  onPressed: () => widget.vm.logout(context),
                  icon: const Icon(Icons.logout),
                  label: const Text("Log out")),
            ],
          ),
        ),
      ),
    );
  }
}

class _Preferences extends StatefulWidget {
  final UserViewModel vm;
  final cs.ColorScheme scheme;
  const _Preferences({super.key, required this.vm, required this.scheme});

  @override
  State<_Preferences> createState() => __PreferencesState();
}

class __PreferencesState extends State<_Preferences> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          TextButton.icon(
              onPressed: () => widget.vm.dislikeSchema(context, widget.scheme),
              icon: Icon(Icons.delete),
              label: Text("Delete")),
          TextButton.icon(
              onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => ExportSchemeView(
                        uvm: widget.vm,
                      )),
              icon: Icon(Icons.share),
              label: Text("Export")),
        ],
      ),
    );
  }
}
