import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:colorful/core/entry/viewmodels/EntryViewModel.dart';
import 'package:colorful/models/color.dart';
import '../../../models/ColorScheme.dart' as cs;

class DecideCard extends StatefulWidget {
  final int index;
  final EntryViewModel vm;
  const DecideCard({
    Key? key,
    required this.index,
    required this.vm,
  }) : super(key: key);

  @override
  State<DecideCard> createState() => _DecideCardState();
}

class _DecideCardState extends State<DecideCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints.loose(Size(300, 450)),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Do you find this color scheme attractive"),
            FutureBuilder<List<cs.ColorScheme>>(
                future: widget.vm.colors,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null)
                    return SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                snapshot.data!.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ColorTile(
                                          color: snapshot.data![widget.index]
                                              .colors[index]),
                                    ))));
                  return const CircularProgressIndicator();
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.arrow_left_rounded),
                    label: Text("Awful")),
                TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.arrow_right_rounded),
                    label: Text("Good"))
              ],
            )
          ],
        ));
  }
}

class ColorTile extends StatelessWidget {
  final ColorModel? color;
  const ColorTile({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: color!.color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(
            color!.name,
            style: TextStyle(
              color: ThemeData.estimateBrightnessForColor(color!.color) ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          Text(
            color!.rgb.toString(),
            style: TextStyle(
              color: ThemeData.estimateBrightnessForColor(color!.color) ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
