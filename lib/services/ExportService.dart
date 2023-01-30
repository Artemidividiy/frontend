import 'dart:developer';

import 'package:colorful/models/ColorScheme.dart';
import 'package:flutter/material.dart' as mt;
import 'package:flutter/services.dart';

class ExportService {
  String generateCSS(ColorScheme scheme) {
    Map<String, String> keys = {};
    keys["primary"] = scheme.colors.first.color.value.toRadixString(16);
    keys["secondary"] = scheme.colors[1].color.value.toRadixString(16);
    for (var i = 2; i < scheme.colorCount; i++) {
      keys["other${i - 1}"] = scheme.colors[i].color.value.toRadixString(16);
    }
    String target = "";
    for (var element in keys.keys.toList()) {
      target += _generateClass(element, keys[element] ?? "undefined error");
    }
    return target;
  }

  String _generateClass(String className, String colorValue) {
    return "/* $className[generated] (${DateTime.now().toIso8601String()}) */\n.$className {\n    $colorValue;\n}";
  }

  void copyToClipboard(mt.BuildContext context, String content) async {
    await Clipboard.setData(ClipboardData(text: '#$content'));
    log("copied to clipboard $content");
    mt.ScaffoldMessenger.of(context)
        .showSnackBar(mt.SnackBar(content: mt.Text("copied to clipboard")));
  }
}
