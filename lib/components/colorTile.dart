import 'package:colorful/models/color.dart';
import 'package:flutter/material.dart';

class ColorTile extends StatelessWidget {
  final ColorModel color;
  const ColorTile({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.color,
      child: Container(
        child: Text(color.name,
            style: TextStyle(
              color: ThemeData.estimateBrightnessForColor(color.color) ==
                      Brightness.light
                  ? Colors.black
                  : Colors.white,
            )),
        constraints: BoxConstraints.tight(Size(Size.infinite.width, 120)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
