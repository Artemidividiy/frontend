import 'dart:math';

import 'package:flutter/material.dart';

typedef ARGS = List Function();

abstract class ColorGenerator {
  Color generate();
}

class BasicGenerator extends ColorGenerator {
  int? _alpha;

  BasicGenerator(this._alpha);

  int? get alpha => _alpha;

  set alpha(int? alpha) {
    _alpha = alpha;
  }

  @override
  Color generate() {
    Random random = Random();
    int r = random.nextInt(256),
        g = random.nextInt(256),
        b = random.nextInt(256);
    _alpha ??= 255;
    return Color.fromARGB(_alpha!, r, g, b);
  }
}

class ToneGenerator extends ColorGenerator {
  @override
  Color generate(
      {Color? baseColor, double? distance = 0, bool? toBlack = false}) {
    return toBlack! == true
        ? Color.lerp(baseColor, Colors.black, distance ?? 0.5) ?? Colors.black
        : Color.lerp(baseColor, Colors.white, distance ?? 0.5) ?? Colors.black;
  }
}
