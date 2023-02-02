import 'package:colorful/core/auth/views/SplashView.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:colorful/services/LocalMemoryService.dart';
import 'package:flutter/material.dart';

class UserViewModel {
  LocalMemoryService _localMemoryService = LocalMemoryService();
  LocalUser? currentUser = LocalUser.instance;

  void logout(BuildContext context) {
    _localMemoryService.logOut().then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => SplashView())));
  }
}
