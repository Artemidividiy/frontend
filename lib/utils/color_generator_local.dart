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
  // Color _baseColor;
  // double? _distance;

  // ToneGenerator({required Color baseColor, double? distance})
  //     : _baseColor = baseColor,
  //       _distance = distance;

  // Color get baseColor => _baseColor;
  // double? get distance => _distance;

  @override
  Color generate({Color? baseColor, double? distance = 0}) {
    return Color.lerp(baseColor, Colors.white, distance ?? 0.5) ?? Colors.black;
  }
}
