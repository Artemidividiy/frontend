import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef onCall = dynamic Function(List arguments);

class Group {
  List<int> items;
  Group(
    this.items,
  );

  Group copyWith({
    List<int>? items,
  }) {
    return Group(
      items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items,
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      List<int>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() => 'Group(items: $items)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Group && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;
}

class ColorModel {
  Color color;
  Group? rgb, hsv, cmyk;
  String name;
  ColorModel({
    required this.color,
    this.cmyk,
    this.rgb,
    this.hsv,
    required this.name,
  }) : assert(cmyk != null || rgb != null || hsv != null);

  ColorModel copyWith({
    required Color color,
    Group? rgb,
    hsv,
    cmyk,
    required String name,
  }) {
    return ColorModel(
      color: color,
      cmyk: cmyk ?? this.cmyk,
      name: name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
      'cmyk': cmyk?.toMap(),
      'rgb': rgb?.toMap(),
      'hsv': hsv?.toMap(),
      'name': name,
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      color: Color(map['color']),
      rgb: Group.fromMap(map['rgb']),
      hsv: Group.fromMap(map['hsv']),
      cmyk: Group.fromMap(map['cmyk']),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) =>
      ColorModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ColorModel(color: $color, cmyk: $cmyk, rgb: $rgb, hsv: $hsv, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorModel &&
        other.color == color &&
        other.cmyk == cmyk &&
        other.name == name;
  }

  @override
  int get hashCode =>
      color.hashCode ^
      cmyk.hashCode ^
      rgb.hashCode ^
      hsv.hashCode ^
      name.hashCode;
}
