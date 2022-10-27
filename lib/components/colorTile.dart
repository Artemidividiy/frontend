import 'dart:developer';

import 'package:colorful/models/color.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ColorTile extends StatefulWidget {
  final ColorModel color;
  ColorTile({Key? key, required this.color}) : super(key: key);

  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  toggle() {
    log('toggled');
    setState(() => _expandableController.toggle());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanel(
      headerBuilder: (c, _) => Container(
        constraints: BoxConstraints.tight(Size(Size.infinite.width, 120)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: widget.color.color),
        alignment: Alignment.center,
        child: Text('${widget.color.name} (rgb : ${_normalizeColor()})',
            style: TextStyle(
              fontSize: 18,
              color: ThemeData.estimateBrightnessForColor(widget.color.color) ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('cmyk: ${widget.color.cmyk}'),
            Text('hsv: ${widget.color.hsv}'),
            TextButton(onPressed: toggle, child: Text("collapse"))
          ],
        ),
      ),
      // child: Container(
      //   constraints: BoxConstraints.tight(Size(Size.infinite.width, 120)),
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(16),
      //       color: widget.color.color),
      //   alignment: Alignment.center,
      //   child: Text('${widget.color.name} (rgb : ${_normalizeColor()})',
      //       style: TextStyle(
      //         fontSize: 18,
      //         color:
      //             ThemeData.estimateBrightnessForColor(widget.color.color) ==
      //                     Brightness.light
      //                 ? Colors.black
      //                 : Colors.white,
      //       )),
      // ),
    ) as Widget;
  }

  _normalizeColor() {
    return "${widget.color.color.red} ${widget.color.color.green} ${widget.color.color.blue}";
  }
}
