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
  late Future<List<ColorTile>> tiles;

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding().addPostFrameCallback((timeStamp) {
      log(timeStamp.toString());
      getColors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Do you find this color scheme attractive"),
          FutureBuilder<List<ColorTile>>(
              future: tiles,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return SingleChildScrollView(
                    child: Column(
                      children: snapshot.data!,
                    ),
                  );
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
      ),
    );
  }

  void getColors() async {
    Future<List<ColorModel>?> colors = MultipleColorController.getColors();
    tiles = Future.sync(List.generate(
            5, (index) => ColorTile(color: Future.sync(colors)[index])))
        .then((value) => tiles = value);
  }
}

class ColorTile extends StatelessWidget {
  final ColorModel? color;
  const ColorTile({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [Text(color!.name), Text(color!.rgb.toString())],
      ),
      decoration: BoxDecoration(color: color!.color),
    );
  }
}
