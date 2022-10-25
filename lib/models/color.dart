import 'dart:convert';

import 'package:flutter/material.dart';

class ColorModel {
  Color color;
  String name;
  ColorModel({
    required this.color,
    required this.name,
  });

  ColorModel copyWith({
    Color? color,
    String? name,
  }) {
    return ColorModel(
      color: color ?? this.color,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color.value,
      'name': name,
    };
  }

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      color: Color(map['color']),
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorModel.fromJson(String source) =>
      ColorModel.fromMap(json.decode(source));

  @override
  String toString() => 'ColorModel(color: $color, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ColorModel && other.color == color && other.name == name;
  }

  @override
  int get hashCode => color.hashCode ^ name.hashCode;
}
