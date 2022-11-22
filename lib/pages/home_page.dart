import 'package:colorful/models/color.dart';
import 'package:colorful/utils/color_generator_local.dart';
import 'package:flutter/material.dart';
import '../components/colorTile.dart';

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

  _normalizeColor(ColorModel color) {
    return "${color.color.red} ${color.color.green} ${color.color.blue}";
  }

  @override
  void initState() {
    currentScheme = 0;
    isOpened = List.generate(5, (index) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        onPressed: fetch,
      ),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              isOpened[panelIndex] = !isExpanded;
            });
          },
          children: List.generate(5, (index) {
            ToneGenerator tg = ToneGenerator();
            Color c = tg.generate(
                baseColor: colorsToRandom[currentScheme],
                distance: index * 0.1);
            ColorModel color = ColorModel(
                color: c,
                name: c.toString(),
                rgb: Group([c.red, c.green, c.blue]));
            return ExpansionPanel(
                canTapOnHeader: true,
                body: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('cmyk: ${color.cmyk}'),
                      Text('hsv: ${color.hsv}'),
                      Text('Tones:'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(10, (tindex) {
                          if (tindex > 4) {
                            Color temp = ToneGenerator().generate(
                                baseColor: color.color, distance: tindex * 0.1);
                            ColorModel tcolor = ColorModel(
                                color: temp,
                                name: index.toString(),
                                rgb: Group([255, 255, 255]));
                            return Container(
                              color: temp,
                              // constraints: BoxConstraints.tight(Size(100, 100)),
                              child: Text(
                                  '${color.color.computeLuminance().toStringAsFixed(3)}'),
                            );
                          } else {
                            Color temp = ToneGenerator().generate(
                                baseColor: color.color,
                                distance: tindex * 0.3,
                                toBlack: true);
                            ColorModel tcolor = ColorModel(
                                color: temp,
                                name: index.toString(),
                                rgb: Group([255, 255, 255]));
                            return Container(
                              color: temp,
                              // constraints: BoxConstraints.tight(Size(100, 100)),
                              child: Text(
                                  '${color.color.computeLuminance().toStringAsFixed(3)}'),
                            );
                          }
                        }),
                      ),
                      TextButton(onPressed: null, child: Text("collapse"))
                    ],
                  ),
                ),
                isExpanded: isOpened[index],
                headerBuilder: (c, isExpanded) => Container(
                    constraints:
                        BoxConstraints.tight(Size(Size.infinite.width, 120)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: color.color),
                    alignment: Alignment.center,
                    child:
                        Text('${color.name} (rgb : ${_normalizeColor(color)})',
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeData.estimateBrightnessForColor(
                                          color.color) ==
                                      Brightness.light
                                  ? Colors.black
                                  : Colors.white,
                            ))));
          }),
        ),
      ),
    );
  }

  void fetch() {
    setState(() {
      currentScheme = (currentScheme + 1) % colorsToRandom.length;
    });
  }
}
