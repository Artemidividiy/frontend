import 'dart:convert';
import 'dart:developer';

import 'package:colorful/utilities/ColorParser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:colorful/enums/status.dart';

class Group {
  List<double> items;
  Group(
    this.items,
  );

  Group copyWith({
    List<double>? items,
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
      List<double>.from(map['items']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() =>
      '${items.map((element) => element.toStringAsPrecision(4)).join()}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Group && listEquals(other.items, items);
  }

  @override
  int get hashCode => items.hashCode;

  double operator [](int index) => items[index];
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
  }) : assert(cmyk != null || rgb != null || hsv != null) {
    if (rgb != null) {
      cmyk = ColorParser.rgbToCmyk(rgb: rgb!);
      hsv = ColorParser.rgbToHsv(rgb: rgb!);
    } else if (hsv != null) {
      cmyk = ColorParser.HsvToCmyk(hsv: hsv!);
      rgb = ColorParser.HsvToRgb(hsv: hsv!);
    } else {
      cmyk = ColorParser.CmykToHsv(cmyk: cmyk!);
      rgb = ColorParser.CmykToRgb(cmyk: cmyk!);
    }
  }

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

  factory ColorModel.fromRGB({required Group rgb}) => ColorModel(
      color: Color.fromRGBO(rgb[0].toInt(), rgb[1].toInt(), rgb[2].toInt(), 1),
      name: "Unknown");

  @override
  int get hashCode =>
      color.hashCode ^
      cmyk.hashCode ^
      rgb.hashCode ^
      hsv.hashCode ^
      name.hashCode;

  Future<ColorModel> getColor({required Group rgbCollection}) async {
    //? i don't get for what it is
    // try {
    //   final pb = PocketBase(PocketBaseConstants.baseURL);
    //   final records = await pb.collection('colors').getFullList(
    //         batch: 200,
    //         sort: '-created',
    //       );
    //   // for (var element in records) {
    //   //   if(element in records) {

    //   //   }
    //   // }
    // } catch (e) {
    return ColorModel(
        color: Color.fromRGBO(rgbCollection[0].toInt(),
            rgbCollection[1].toInt(), rgbCollection[2].toInt(), 1),
        name: "Unknown");
    // }
  }
  //! deprecated boi
  // Future<Status> pushColor({required ColorModel color}) async {
  //   Status target = Status.waiting;
  //   try {
  //     target = Status.pushing;
  //     final pb = PocketBase(PocketBaseConstants.baseURL);
  //     final body = <String, dynamic>{
  //       "name": color.name,
  //       "r_value": color.rgb![0],
  //       "g_value": color.rgb![1],
  //       "b_value": color.rgb![2]
  //     };
  //     final record = await pb.collection('colors').create(body: body);
  //     return Status.completed;
  //   } catch (e) {
  //     log("error:", error: e);
  //     return Status.error;
  //   }
  // }

  String toHexString() {
    return "#${this.rgb!.items[0].toInt().toRadixString(16)}${this.rgb!.items[1].toInt().toRadixString(16)}${this.rgb!.items[2].toInt().toRadixString(16)}";
  }
}
