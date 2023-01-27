import 'dart:developer';

import 'package:colorful/models/LocalUser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalMemoryService {
  final _secureStorageInstance = FlutterSecureStorage();
  LocalUser? currentUser;
  LocalMemoryService() {}

  _getUserFromMemory() async {
    try {
      currentUser = LocalUser.fromString(
          await _secureStorageInstance.read(key: "current user"));
      LocalUser.instance = currentUser;
    } catch (e) {
      log("user not found", error: e);
    }
  }
}
