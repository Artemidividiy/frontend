import 'package:colorful/controllers/color_controller.dart';
import 'package:colorful/models/color.dart';
import 'package:colorful/utils/color_generator_local.dart';
import 'package:flutter/material.dart';

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
  late Future<List<ColorModel>?> currentScheme;
  late List<bool> isOpened;
  ALGO algo = ALGO.monochrome;
  _normalizeColor(ColorModel color) {
    return "${color.color.red} ${color.color.green} ${color.color.blue}";
  }

  @override
  void initState() {
    isOpened = List.generate(5, (index) => false);
    super.initState();
    currentScheme = MultipleColorController.getRandomColorsWithAlgo(algo: algo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.add),
        onPressed: fetch,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            ConstrainedBox(
              constraints: BoxConstraints.loose(Size(Size.infinite.width, 100)),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  FilterChip(
                      label: const Text("monochrome"),
                      selected: ALGO.monochrome == algo ? true : false,
                      onSelected: (value) => setState(() {
                            algo = ALGO.monochrome;
                          })),
                  FilterChip(
                      label: const Text("analogic"),
                      selected: ALGO.analogic == algo ? true : false,
                      onSelected: (value) => setState(() {
                            algo = ALGO.analogic;
                          })),
                  FilterChip(
                      label: const Text("complement"),
                      selected: ALGO.complement == algo ? true : false,
                      onSelected: (value) => setState(() {
                            algo = ALGO.complement;
                          })),
                  FilterChip(
                      label: const Text("analogic-complement"),
                      selected: ALGO.analogicComplement == algo ? true : false,
                      onSelected: (value) => setState(() {
                            algo = ALGO.analogicComplement;
                          })),
                  FilterChip(
                      label: const Text("triad"),
                      selected: ALGO.triad == algo ? true : false,
                      onSelected: (value) => setState(() {
                            algo = ALGO.triad;
                          })),
                  FilterChip(
                      label: const Text("quad"),
                      selected: ALGO.quad == algo ? true : false,
                      onSelected: (value) => setState(() {
                            algo = ALGO.quad;
                          })),
                ],
              ),
            ),
            FutureBuilder<List<ColorModel>?>(
                future: currentScheme,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ExpansionPanelList(
                      expansionCallback: (panelIndex, isExpanded) {
                        setState(() {
                          isOpened[panelIndex] = !isExpanded;
                        });
                      },
                      children: List.generate(5, (index) {
                        return ExpansionPanel(
                            canTapOnHeader: true,
                            body: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('cmyk: ${snapshot.data![index].cmyk}'),
                                  Text('hsv: ${snapshot.data![index].hsv}'),
                                  const Text('Tones:'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(10, (tindex) {
                                      if (tindex > 4) {
                                        Color temp = ToneGenerator().generate(
                                            baseColor:
                                                snapshot.data![index].color,
                                            distance: tindex * 0.1);
                                        ColorModel tcolor = ColorModel(
                                            color: temp,
                                            name: index.toString(),
                                            rgb: Group([255, 255, 255]));
                                        return Container(
                                          color: temp,
                                          // constraints: BoxConstraints.tight(Size(100, 100)),
                                          child: Text(snapshot
                                              .data![index].color
                                              .computeLuminance()
                                              .toStringAsFixed(3)),
                                        );
                                      } else {
                                        Color temp = ToneGenerator().generate(
                                            baseColor:
                                                snapshot.data![index].color,
                                            distance: tindex * 0.3,
                                            toBlack: true);
                                        ColorModel tcolor = ColorModel(
                                            color: temp,
                                            name: index.toString(),
                                            rgb: Group([255, 255, 255]));
                                        return Container(
                                          color: temp,
                                          // constraints: BoxConstraints.tight(Size(100, 100)),
                                          child: Text(snapshot
                                              .data![index].color
                                              .computeLuminance()
                                              .toStringAsFixed(3)),
                                        );
                                      }
                                    }),
                                  ),
                                  const TextButton(
                                      onPressed: null,
                                      child: const Text("collapse"))
                                ],
                              ),
                            ),
                            isExpanded: isOpened[index],
                            headerBuilder: (c, isExpanded) => Container(
                                constraints: BoxConstraints.tight(
                                    Size(Size.infinite.width, 120)),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: snapshot.data![index].color),
                                alignment: Alignment.center,
                                child: Text(
                                    '${snapshot.data![index].name} (rgb : ${_normalizeColor(snapshot.data![index])})',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color:
                                          ThemeData.estimateBrightnessForColor(
                                                      snapshot.data![index]
                                                          .color) ==
                                                  Brightness.light
                                              ? Colors.black
                                              : Colors.white,
                                    ))));
                      }),
                    );
                  }
                  return const Center(child: const CircularProgressIndicator());
                })
          ]),
        ),
      ),
    );
  }

  void fetch() async {
    var target = MultipleColorController.getRandomColorsWithAlgo(algo: algo);
    if (target != null)
      setState(() {
        currentScheme = target;

        // currentScheme = target;
      });
  }
}
