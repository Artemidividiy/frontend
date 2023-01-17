import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../enums/algo.dart';
import '../models/color.dart';
import '../constants/ColorsAPIConstants.dart';
import '../utilities/color_generator_local.dart';

mixin parser {
  static parse(Map<String, dynamic> map) {
    return ColorModel(
        rgb: Group([map['rgb']['r'], map['rgb']['g'], map['rgb']['b']]),
        color: Color(int.parse("0xFF" + map['hex']['clean'])),
        name: map['name']['value']);
  }
}

String _algoNameParser(ALGO algo) {
  String target = algo.name.replaceAllMapped(
      RegExp(r'[A-Z]'), (match) => "-${match[0]!.toLowerCase()}");
  log(target);
  return target;
}

class ColorService {
  Future<ColorModel?> getColorByColor({required Color color}) async {
    log("trying to get scheme");
    try {
      var response = await http.get(Uri.parse(
          BASE_PATH + "id?" + _normalizeColor(color) + "&format=json"));
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
      {ALGO? algo = ALGO.analogic}) async {
    log("trying to get scheme");
    try {
      List<ColorModel> target = [];
      Color color = BasicGenerator(null).generate();
      var response = await http.get(Uri.parse(BASE_PATH +
          "scheme?" +
          _normalizeColor(color) +
          "format=json&mode=${_algoNameParser(algo!)}&count=5"));
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

  _normalizeColor(Color color) {
    return "rgb=" +
        color.red.toString() +
        "," +
        color.green.toString() +
        "," +
        color.blue.toString();
  }

  _parse(Map<String, dynamic> map) {
    return ColorModel(
        rgb: Group([map['rgb']['r'], map['rgb']['g'], map['rgb']['b']]),
        color: Color(int.parse("0xFF" + map['hex']['clean'])),
        name: map['name']['value']);
  }
}
