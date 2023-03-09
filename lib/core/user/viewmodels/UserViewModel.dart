import 'package:colorful/core/auth/views/SplashView.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:colorful/services/ColorService.dart';
import 'package:colorful/services/LocalMemoryService.dart';
import 'package:flutter/material.dart';
import '../../../models/ColorScheme.dart' as cs;
import '../../../services/ExportService.dart';

class UserViewModel {
  LocalMemoryService _localMemoryService = LocalMemoryService();
  LocalUser? currentUser = LocalUser.instance;
  Future<List<cs.ColorScheme>>? liked_schemes;
  ExportService _exportService = ExportService();
  static cs.ColorScheme? currentScheme;

  init() {
    liked_schemes = ColorService().fetchLikedSchemas();
  }

  Future dislikeSchema(BuildContext context, cs.ColorScheme scheme) async {
    ColorService()
        .dislikeScheme(scheme: scheme)
        .then((_) => Navigator.of(context).pop());
  }

  Future<String> exportScheme() async {
    return _exportService.generateCSS((currentScheme)!);
  }

  void copyToClipboard(BuildContext context) {
    _exportService.copyToClipboard(context, currentScheme.toString());
    Navigator.of(context).pop();
  }

  void copyTextToClipboard(BuildContext context, String content) {
    _exportService.copyToClipboard(context, content);
    Navigator.of(context).pop();
  }

  void logout(BuildContext context) {
    _localMemoryService.logOut().then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => SplashView())));
  }
}
