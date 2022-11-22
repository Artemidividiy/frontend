import 'dart:developer';

import 'package:colorful/controllers/colorController.dart';
import 'package:colorful/models/color.dart';
import 'package:flutter/material.dart';

class DecideCard extends StatefulWidget {
  const DecideCard({Key? key}) : super(key: key);

  @override
  State<DecideCard> createState() => _DecideCardState();
}

class _DecideCardState extends State<DecideCard> {
  Future<List<ColorModel>?>? _scheme;

  @override
  void initState() {
    super.initState();
    _scheme = MultipleColorController.getColors();
  }

  @override
  void didUpdateWidget(covariant DecideCard oldWidget) {
    return;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        constraints: BoxConstraints.loose(Size(300, 450)),
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(16),
            color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Do you find this color scheme attractive"),
            FutureBuilder<List<ColorModel>?>(
                future: _scheme,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null)
                    return SingleChildScrollView(
                        child: Column(
                            children: List.generate(
                                snapshot.data!.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ColorTile(
                                          color: snapshot.data![index]),
                                    ))));

                  return CircularProgressIndicator();
                }),
            Row(
              children: [
                TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.check),
                    label: Text("Good")),
                TextButton.icon(
                    onPressed: null,
                    icon: Icon(Icons.delete),
                    label: Text("Awful"))
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
        children: [Text(color!.name), Text(color!.rgb.toString())],
      ),
    );
  }
}
