import 'dart:collection';
import 'dart:math';
import 'package:colorful/models/Hex.dart';
import 'package:colorful/models/color.dart';
import 'package:flutter/material.dart';

class ColorParser {
  //? source:
  // https://www.had2know.org/technology/hsv-rgb-conversion-formula-calculator.html
  static Group rgbToHsv({required Group rgb}) {
    List tmp = rgb.items.map((e) => e).toList();
    tmp.sort();
    num M = tmp.last;
    num m = tmp.first;
    num v = M / 255;
    num s = 0;
    if (rgb.items.every((element) => element == 255)) return Group([0, 0, 1]);
    if (M > 0) s = 1 - m / M;
    num h = 0;
    if (rgb.items[1] >= rgb.items[2])
      h = acos((rgb.items[0] - rgb.items[1] / 2 - rgb.items[2] / 2) /
          sqrt(pow(rgb.items[0], 2) +
              pow(rgb.items[1], 2) +
              pow(rgb.items[2], 2) -
              rgb.items[0] * rgb.items[1] -
              rgb.items[0] * rgb.items[2] -
              rgb.items[1] * rgb.items[2]));
    else
      h = 360 -
          acos((rgb.items[0] - rgb.items[1] / 2 - rgb.items[2] / 2) /
              sqrt(pow(rgb.items[0], 2) +
                  pow(rgb.items[1], 2) +
                  pow(rgb.items[2], 2) -
                  rgb.items[0] * rgb.items[1] -
                  rgb.items[0] * rgb.items[2] -
                  rgb.items[1] * rgb.items[2]));
    return Group([h.toDouble(), s.toDouble(), v.toDouble()]);
  }

  static Group rgbToCmyk({required Group rgb}) {
    double new_r = rgb[0].toDouble() / 255;
    double new_g = rgb[1].toDouble() / 255;
    double new_b = rgb[2].toDouble() / 255;
    List tmp = [new_r, new_b, new_g];
    double k = 1 - tmp.max().toDouble();
    double c = (1 - new_r - k) / (1 - k);
    double m = (1 - new_g - k) / (1 - k);
    double y = (1 - new_b - k) / (1 - k);
    return Group([c, m, y, k]);
  }

  //? source:
  // https://www.had2know.org/technology/hsv-rgb-conversion-formula-calculator.html
  static Group HsvToRgb({required Group hsv}) {
    num v = hsv.items[2];
    num s = hsv.items[1];
    num h = hsv.items[0];
    num M = 255 * v;
    num m = M * (1 - s);
    num r = 0, g = 0, b = 0;
    num z = (M - m) * (1 - ((h - 60) % 2 - 1).abs());
    if (0 <= h && h < 60) {
      r = M;
      g = z + m;
      b = m;
    }
    if (60 <= h && h < 120) {
      r = z + m;
      g = M;
      b = m;
    }
    if (120 <= h && h < 180) {
      r = m;
      g = M;
      b = z + m;
    }
    if (180 <= h && h < 240) {
      r = m;
      g = z + m;
      b = M;
    }
    if (240 <= h && h < 300) {
      r = z + m;
      g = m;
      b = M;
    }
    if (300 <= h && h < 360) {
      r = M;
      g = m;
      b = z + m;
    }
    return Group([r.toDouble(), g.toDouble(), b.toDouble()]);
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

  static Hex RgbToHex({required Group rgb}) => Hex.fromGroup(group: rgb);
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
    double target = -256;
    if (this == null) throw Exception();
    for (var element in this) {
      if ((element as double) > target) {
        target = element;
      }
    }
    return target;
  }
}
