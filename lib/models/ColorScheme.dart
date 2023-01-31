import 'dart:convert';

import 'package:colorful/models/color.dart';
import 'package:colorful/utilities/AlgoUtils.dart';
import 'package:flutter/foundation.dart';

import 'package:colorful/enums/algo.dart';

class ColorScheme {
  List<ColorModel> colors;
  int colorCount;
  ALGO schemeAlgo;
  ColorScheme({
    required this.colors,
    required this.colorCount,
    required this.schemeAlgo,
  });

  ColorScheme copyWith({
    List<ColorModel>? colors,
    int? colorCount,
    ALGO? schemeAlgo,
  }) {
    return ColorScheme(
      colors: colors ?? this.colors,
      colorCount: colorCount ?? this.colorCount,
      schemeAlgo: schemeAlgo ?? this.schemeAlgo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'colors': colors.map((x) => x.toMap()).toList(),
      'colorCount': colorCount,
      'schemeAlgo': schemeAlgo.toString(),
    };
  }

  factory ColorScheme.fromMap(Map<String, dynamic> map) {
    return ColorScheme(
      colors: List<ColorModel>.from(
          map['colors']?.map((x) => ColorModel.fromMap(x))),
      colorCount: map['colorCount']?.toInt() ?? 0,
      schemeAlgo: stringToAlgo(map['schemeAlgo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorScheme.fromJson(String source) =>
      ColorScheme.fromMap(json.decode(source));

  factory ColorScheme.fromListColors(List<ColorModel> colors, ALGO algo) =>
      ColorScheme(colorCount: colors.length, colors: colors, schemeAlgo: algo);

  factory ColorScheme.fromQRCodeData(String string) {
    return ColorScheme.fromJson(string);
  }

  @override
  String toString() => '${colors.map((element) {
        return element.toString() + "---";
      })}\n$colorCount\n$schemeAlgo';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorScheme &&
        listEquals(other.colors, colors) &&
        other.colorCount == colorCount &&
        other.schemeAlgo == schemeAlgo;
  }

  @override
  int get hashCode =>
      colors.hashCode ^ colorCount.hashCode ^ schemeAlgo.hashCode;
}
