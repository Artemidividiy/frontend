import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/EntryViewconstants.dart';
import '../enums/algo.dart';
import '../models/color.dart';
import '../constants/ColorsAPIConstants.dart';
import '../utilities/AlgoUtils.dart';
import '../utilities/ColorParser.dart';
import '../utilities/color_generator_local.dart';
import '../models/ColorScheme.dart' as cs;

mixin parser {
  static parse(Map<String, dynamic> map) {
    return ColorModel(
        rgb: Group([
          (map['rgb']['r'] as num).toDouble(),
          (map['rgb']['g'] as num).toDouble(),
          (map['rgb']['b'] as num).toDouble()
        ]),
        color: Color(int.parse("0xFF" + map['hex']['clean'])),
        name: map['name']['value']);
  }
}

class ColorService {
  Future<ColorModel?> getColorByColor({required Color color}) async {
    log("trying to get scheme");
    try {
      var response = await http.get(Uri.parse(
          BASE_PATH + "id?" + normalizeColor(color) + "&format=json"));
      var data = json.decode(response.body);
      return _parse(data);
    } catch (e) {
      log("error occured", error: e);
    }
  }

  Future<ColorModel?> getColorByHex({required String hex}) async {
    log("trying to get scheme");
    try {
      var response = await http.get(
          Uri.parse(BASE_PATH + "id?hex=" + hex.toString() + "&format=json"));
      var data = json.decode(response.body);
      return _parse(data);
    } catch (e) {
      log("error occured", error: e);
    }
  }

  Future<List<ColorModel>?> getRandomColorsWithAlgo(
      {ALGO? algo = ALGO.analogic,
      int colorsCount = 5,
      ColorModel? baseColor}) async {
    log("trying to get scheme");
    try {
      List<ColorModel> target = [];
      var color = baseColor?.color;
      color ??= BasicGenerator(null).generate();
      var response = await http.get(Uri.parse(BASE_PATH +
          "scheme?" +
          normalizeColor(color) +
          "format=json&mode=${algoToString(algo!)}&count=$colorsCount"));
      var data = json.decode(response.body);
      for (var element in data['colors']) {
        target.add(
          parser.parse(element),
        );
      }
      return target;
    } catch (e) {
      log("error occured: ", error: e);
    }
  }

  Future<List<cs.ColorScheme>> getMultipleColorSchemes(
      {ALGO algo = ALGO.analogic, int count = schemeCount}) async {
    log("trying to get multiple schemes");
    List<cs.ColorScheme> target = [];
    for (var i = 0; i < count; i++) {
      List<ColorModel> tmp = [];
      Color color = BasicGenerator(null).generate();
      var response = await http.get(Uri.parse(BASE_PATH +
          "scheme?" +
          normalizeColor(color) +
          "format=json&mode=${algoToString(algo!)}&count=5"));
      var data = json.decode(response.body);
      for (var element in data['colors']) {
        tmp.add(
          parser.parse(element),
        );
      }
      target.add(cs.ColorScheme.fromListColors(tmp, algo));
    }
    return target;
  }

  _parse(Map<String, dynamic> map) {
    return ColorModel(
        rgb: Group([map['rgb']['r'], map['rgb']['g'], map['rgb']['b']]),
        color: Color(int.parse("0xFF" + map['hex']['clean'])),
        name: map['name']['value']);
  }
}
