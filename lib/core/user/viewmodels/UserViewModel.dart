import 'package:colorful/core/auth/views/SplashView.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:colorful/services/ColorService.dart';
import 'package:colorful/services/LocalMemoryService.dart';
import 'package:flutter/material.dart';
import '../../../models/ColorScheme.dart' as cs;

class UserViewModel {
  LocalMemoryService _localMemoryService = LocalMemoryService();
  LocalUser? currentUser = LocalUser.instance;
  Future<List<cs.ColorScheme>>? liked_schemes;

  init() {
    liked_schemes = ColorService().fetchLikedSchemas();
  }

  void logout(BuildContext context) {
    _localMemoryService.logOut().then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => SplashView())));
  }
}
