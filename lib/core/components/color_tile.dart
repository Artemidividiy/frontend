import 'package:colorful/models/color.dart';
import 'package:colorful/core/home/views/HomeView.dart';
import 'package:flutter/material.dart';

ExpansionPanel makeColorTile(
    {required BuildContext context,
    required ColorModel color,
    required bool isExpanded}) {
  _normalizeColor() {
    return "${color.color.red} ${color.color.green} ${color.color.blue}";
  }

  return ExpansionPanel(
      canTapOnHeader: true,
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('cmyk: ${color.cmyk}'),
            Text('hsv: ${color.hsv}'),
            TextButton(onPressed: null, child: Text("collapse"))
          ],
        ),
      ),
      isExpanded: isExpanded,
      headerBuilder: (c, isExpanded) => !isExpanded
          ? Container(
              constraints: BoxConstraints.tight(Size(Size.infinite.width, 120)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16), color: color.color),
              alignment: Alignment.center,
              child: Text('${color.name} (rgb : ${_normalizeColor()})',
                  style: TextStyle(
                    fontSize: 18,
                    color: ThemeData.estimateBrightnessForColor(color.color) ==
                            Brightness.light
                        ? Colors.black
                        : Colors.white,
                  )))
          : Text('${color.name}')
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
      );
}
