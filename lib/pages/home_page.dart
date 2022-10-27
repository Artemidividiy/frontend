import 'dart:developer';

import 'package:colorful/controllers/colorController.dart';
import 'package:colorful/models/color.dart';
import 'package:colorful/utils/color_generator_local.dart';
import 'package:flutter/material.dart';
import '../components/colorTile2.0.dart';

List<Color> colorsToRandom = [
  Colors.indigo,
  Colors.black,
  Colors.amber,
  Colors.cyan
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentScheme;
  late List<bool> isOpened;
  late List<ExpansionPanel> items;
  @override
  void initState() {
    currentScheme = 0;
    ToneGenerator tg = ToneGenerator();
    isOpened = List.generate(5, (index) => false);
    items = List.generate(5, (index) {
      Color color = tg.generate(
          baseColor: colorsToRandom[currentScheme], distance: index * 0.1);
      return makeColorTile(
          isExpanded: isOpened[index],
          context: context,
          color: ColorModel(
              color: color,
              name: color.toString(),
              rgb: Group([color.red, color.green, color.blue])));
    });
    super.initState();
  }

  Future<void> redraw() async {
    ToneGenerator tg = ToneGenerator();
    setState(() {
      currentScheme == 3 ? currentScheme = 0 : currentScheme++;
      items = List.generate(10, (index) {
        Color color = tg.generate(
            baseColor: colorsToRandom[currentScheme], distance: index * 0.1);
        return makeColorTile(
            isExpanded: false,
            context: context,
            color: ColorModel(
                color: color,
                name: color.toString(),
                rgb: Group([color.red, color.green, color.blue])));
      });
      isOpened = List.generate(items.length, (index) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
          onPressed: () async {
            List<ColorModel>? colors =
                await MultipleColorController.getColors();
            if (colors != null) {
              isOpened = List.generate(5, (index) => false);
              setState(() {
                items = List.generate(
                    colors.length,
                    (index) => makeColorTile(
                        isExpanded: isOpened[index],
                        context: context,
                        color: colors[index]));
              });
            }
          },
          icon: Icon(Icons.add)),

      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              isOpened[panelIndex] = isExpanded;
            });
          },
          children: items,
        ),
      ),

      // body:
    );
  }
}
