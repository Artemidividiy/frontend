import 'dart:developer';

import 'package:colorful/core/home/views/ExportSchemeView.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../models/ColorScheme.dart' as cs;
import 'package:colorful/enums/algo.dart';
import 'package:colorful/models/color.dart';
import 'package:colorful/services/ColorService.dart';
import 'package:colorful/services/ExportService.dart';
import 'package:flutter/material.dart';

import '../../../models/ColorScheme.dart';

class HomeViewModel {
  ColorService _colorService = ColorService();
  ExportService _exportService = ExportService();
  int colorsCount = 5;
  ColorModel? baseColor;
  ALGO algo = ALGO.monochrome;
  QRViewController? qrViewController;
  late Future<List<cs.ColorScheme>?> currentScheme;
  HomeViewModel() {
    this.currentScheme =
        _colorService.getMultipleColorSchemes(algo: algo, count: 1);
  }

  Future<List<cs.ColorScheme>?> fetch() async {
    var target = _colorService.getMultipleColorSchemes(algo: algo, count: 1);
    if (target != null) return currentScheme = target;
    // currentScheme = target;
  }

  Future<String> exportScheme() async {
    return _exportService.generateCSS((await currentScheme)!.first);
  }

  void copyToClipboard(BuildContext context) {
    _exportService.copyToClipboard(context, currentScheme.toString());
    Navigator.of(context).pop();
  }

  void copyTextToClipboard(BuildContext context, String content) {
    _exportService.copyToClipboard(context, content);
    Navigator.of(context).pop();
  }

  cs.ColorScheme importFromQrCode(BuildContext context, String scannedData) =>
      _exportService.importSchemeFromQRCode(context, scannedData);
}
