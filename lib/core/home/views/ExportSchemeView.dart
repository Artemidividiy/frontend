import 'package:colorful/core/home/viewmodels/HomeViewModel.dart';
import 'package:colorful/core/user/views/UserView.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../user/viewmodels/UserViewModel.dart';

class ExportSchemeView extends StatefulWidget {
  final HomeViewModel? vm;
  final UserViewModel? uvm;
  const ExportSchemeView({super.key, this.vm, this.uvm})
      : assert(vm != null || uvm != null);

  @override
  State<ExportSchemeView> createState() => _ExportSchemeViewState();
}

class _ExportSchemeViewState extends State<ExportSchemeView> {
  late HomeViewModel? vm;
  late UserViewModel? uvm;
  late ValueNotifier<String?> cssTextNotifier;
  List selectedValues = [false, false, false];
  double height = 100;
  @override
  void initState() {
    vm = widget.vm;
    uvm = widget.uvm;
    cssTextNotifier = ValueNotifier(null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      duration: Duration(milliseconds: 125),
      child: SingleChildScrollView(
        primary: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<String?>(
                valueListenable: cssTextNotifier,
                builder: (context, value, child) {
                  if (value == null) {
                    return Column(children: [
                      Text("Choose export method"),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ChoiceChip(
                                  selected: selectedValues[0],
                                  onSelected: (value) {
                                    setState(() {
                                      selectedValues[0] = value;
                                    });
                                    vm != null
                                        ? vm!.copyToClipboard(context)
                                        : uvm!.copyToClipboard(context);
                                  },
                                  label: Text("copy to clipboard")),
                              ChoiceChip(
                                  selected: selectedValues[1],
                                  onSelected: (value) async {
                                    cssTextNotifier = ValueNotifier<String>(
                                        vm != null
                                            ? await vm!.exportScheme()
                                            : await uvm!.exportScheme());
                                    setState(() {
                                      selectedValues[1] = value;
                                      height = 400;
                                    });
                                  },
                                  label: Text("export to css")),
                              ChoiceChip(
                                  selected: selectedValues[2],
                                  onSelected: (value) async {
                                    cssTextNotifier = ValueNotifier<String>(
                                        vm != null
                                            ? "qr-" +
                                                (await vm!.currentScheme)!
                                                    .toList()
                                                    .first
                                                    .toJson()
                                                    .toString()
                                            : "qr-" +
                                                UserViewModel.currentScheme!
                                                    .toJson()
                                                    .toString());
                                    setState(() {
                                      height = 450;
                                      selectedValues[2] = value;
                                    });
                                  },
                                  label: Text("view qr-code"))
                            ],
                          ))
                    ]);
                  } else if (value.contains("qr-")) {
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: QrImage(
                        data: value.substring(3),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(value),
                          IconButton(
                              onPressed: () => vm != null
                                  ? vm!.copyTextToClipboard(context, value)
                                  : uvm!.copyTextToClipboard(context, value),
                              icon: Icon(Icons.copy_all))
                        ],
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
