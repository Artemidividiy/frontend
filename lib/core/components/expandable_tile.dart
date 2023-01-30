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
              height: isExpanded ? 400 : 0,
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
    Group cmyk = snapshot.data![index].cmyk!;
    Group hsv = snapshot.data![index].hsv!;
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
              Text(
                'CMYK:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Table(
                children: [
                  TableRow(
                      children: [Text("C"), Text("M"), Text("Y"), Text("K")]),
                  TableRow(children: [
                    Text(cmyk[0].toStringAsPrecision(4)),
                    Text(cmyk[1].toStringAsPrecision(4)),
                    Text(cmyk[2].toStringAsPrecision(4)),
                    Text(cmyk[3].toStringAsPrecision(4))
                  ])
                ],
              ),
              // Text(
              //     '${ColorParser.rgbToCmyk(rgb: snapshot.data![index].rgb!).toString()}'),
              Text(
                'HSV:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Table(
                children: [
                  TableRow(children: [
                    Text("H"),
                    Text("S"),
                    Text("V"),
                  ]),
                  TableRow(children: [
                    Text(hsv[0].toStringAsPrecision(4)),
                    Text(hsv[1].toStringAsPrecision(4)),
                    Text(hsv[2].toStringAsPrecision(4)),
                  ])
                ],
              ),
              const Text('Tones:'),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 4,
                children: List.generate(8, (tindex) {
                  if (tindex > 3) {
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
                    );
                  }
                }),
              ),
              Text("Luminance:"),
              Text(
                snapshot.data![index].color
                    .computeLuminance()
                    .toStringAsFixed(6),
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        header: Container(
            constraints: BoxConstraints.tight(Size(Size.infinite.width, 120)),
            decoration: BoxDecoration(color: snapshot.data![index].color),
            alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ThemeData.estimateBrightnessForColor(
                            snapshot.data![index].color) ==
                        Brightness.light
                    ? Colors.black54
                    : Colors.white54,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(snapshot.data![index].name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeData.estimateBrightnessForColor(
                                    snapshot.data![index].color) ==
                                Brightness.light
                            ? Colors.white
                            : Colors.black,
                      )),
                  Text(
                    snapshot.data![index].toHexString().toUpperCase(),
                    style: TextStyle(
                      color: ThemeData.estimateBrightnessForColor(
                                  snapshot.data![index].color) ==
                              Brightness.light
                          ? Colors.white
                          : Colors.black,
                    ),
                  )
                ],
              ),
            )));
  }
}
