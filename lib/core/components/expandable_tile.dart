import 'package:flutter/material.dart';

import '../../models/color.dart';
import '../../utilities/color_generator_local.dart';
import '../../utilities/ColorParser.dart';

class ExpandableTile extends StatefulWidget {
  final Widget? header;
  final Widget? body;

  const ExpandableTile({
    super.key,
    required this.header,
    required this.body,
  });

  @override
  State<ExpandableTile> createState() => _ExpandableTileState();
}

class _ExpandableTileState extends State<ExpandableTile> {
  late bool isExpanded;
  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          GestureDetector(
            onTap: _showBody,
            child: _ExpandableHeader(
              content: widget.header ?? Container(),
            ),
          ),
          AnimatedContainer(
              curve: Curves.easeInOutQuart,
              height: isExpanded ? 300 : 0,
              duration: Duration(milliseconds: 250),
              child: isExpanded
                  ? _ExpandableBody(
                      content: widget.body ?? Container(),
                    )
                  : Container())
        ]),
      ),
    );
  }

  void _showBody() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}

class _ExpandableHeader extends StatelessWidget {
  final Widget content;
  const _ExpandableHeader({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return content;
  }
}

class _ExpandableBody extends StatelessWidget {
  final Widget content;
  const _ExpandableBody({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return content;
  }
}

extension Designed on ExpandableTile {
  widget(
      {required AsyncSnapshot<List<ColorModel>?> snapshot,
      required int index}) {
    return ExpandableTile(
        body: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('cmyk: ${snapshot.data![index].cmyk}'),
              Text('hsv: ${snapshot.data![index].hsv}'),
              const Text('Tones:'),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 5,
                children: List.generate(10, (tindex) {
                  if (tindex > 4) {
                    Color temp = ToneGenerator().generate(
                        baseColor: snapshot.data![index].color,
                        distance: tindex * 0.1);
                    ColorModel tcolor = ColorModel(
                        color: temp,
                        name: index.toString(),
                        rgb: Group([255, 255, 255]));
                    return Container(
                      decoration: BoxDecoration(
                          color: temp, borderRadius: BorderRadius.circular(4)),
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(4),
                      // constraints: BoxConstraints.tight(Size(100, 100)),
                      child: Text(
                        snapshot.data![index].color
                            .computeLuminance()
                            .toStringAsFixed(3),
                        style: TextStyle(
                          color: ThemeData.estimateBrightnessForColor(temp) ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    );
                  } else {
                    Color temp = ToneGenerator().generate(
                        baseColor: snapshot.data![index].color,
                        distance: tindex * 0.3,
                        toBlack: true);
                    ColorModel tcolor = ColorModel(
                        color: temp,
                        name: index.toString(),
                        rgb: Group([255, 255, 255]));
                    return Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: temp, borderRadius: BorderRadius.circular(4)),
                      margin: EdgeInsets.all(8),

                      // constraints: BoxConstraints.tight(Size(100, 100)),
                      child: Text(
                        snapshot.data![index].color
                            .computeLuminance()
                            .toStringAsFixed(3),
                        style: TextStyle(
                          color: ThemeData.estimateBrightnessForColor(temp) ==
                                  Brightness.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    );
                  }
                }),
              ),
              const TextButton(onPressed: null, child: const Text("collapse"))
            ],
          ),
        ),
        header: Container(
            constraints: BoxConstraints.tight(Size(Size.infinite.width, 120)),
            decoration: BoxDecoration(color: snapshot.data![index].color),
            alignment: Alignment.center,
            child: Text(
                '${snapshot.data![index].name} (rgb : ${normalizeColor(snapshot.data![index].color)})',
                style: TextStyle(
                  fontSize: 18,
                  color: ThemeData.estimateBrightnessForColor(
                              snapshot.data![index].color) ==
                          Brightness.light
                      ? Colors.black
                      : Colors.white,
                ))));
  }
}
