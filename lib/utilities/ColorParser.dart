import 'dart:collection';
import 'dart:math';
import 'package:colorful/models/color.dart';
import 'package:flutter/material.dart';

class ColorParser {
  static Group rgbToHsv({required Group rgb}) {
    throw UnimplementedError();
  }

  static Group rgbToCmyk({required Group rgb}) {
    double new_r = rgb[0].toDouble() / 255;
    double new_g = rgb[1].toDouble() / 255;
    double new_b = rgb[2].toDouble() / 255;
    num k = 1 - List.from([new_r, new_b, new_g]).max();
    double c = (1 - new_r - k) / (1 - k);
    double m = (1 - new_g - k) / (1 - k);
    double y = (1 - new_b - k) / (1 - k);
    return Group([c.round(), m.round(), y.round(), k.toDouble().round()]);
  }

  static Group HsvToRgb({required Group hsv}) {
    throw UnimplementedError();
  }

  static Group HsvToCmyk({required Group hsv}) {
    throw UnimplementedError();
  }

  static Group CmykToRgb({required Group cmyk}) {
    throw UnimplementedError();
  }

  static Group CmykToHsv({required Group cmyk}) {
    throw UnimplementedError();
  }
}

normalizeColor(Color color) {
  return "rgb=" +
      color.red.toString() +
      "," +
      color.green.toString() +
      "," +
      color.blue.toString();
}

extension ListMax on List {
  num max() {
    double target = 256;
    if (this == null) throw Exception();
    for (var element in this) {
      if ((element as double) > target) {
        target = element;
      }
    }
    return target;
  }
}
