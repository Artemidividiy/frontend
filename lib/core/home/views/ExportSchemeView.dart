import 'package:colorful/core/home/viewmodels/HomeViewModel.dart';
import 'package:flutter/material.dart';

class ExportSchemeView extends StatefulWidget {
  final HomeViewModel vm;
  const ExportSchemeView({super.key, required this.vm});

  @override
  State<ExportSchemeView> createState() => _ExportSchemeViewState();
}

class _ExportSchemeViewState extends State<ExportSchemeView> {
  late HomeViewModel vm;
  late ValueNotifier<String?> cssTextNotifier;
  double height = 100;
  @override
  void initState() {
    vm = widget.vm;
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
                      Row(
                        children: [
                          TextButton(
                              onPressed: () => vm.copyToClipboard(context),
                              child: Text("copy to clipboard")),
                          TextButton(
                              onPressed: () async {
                                cssTextNotifier = ValueNotifier<String>(
                                    await vm.exportScheme());
                                setState(() {
                                  height = 400;
                                });
                              },
                              child: Text("export to css"))
                        ],
                      )
                    ]);
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(value),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
