import 'dart:developer';

import 'package:colorful/enums/AuthStatus.dart';
import 'package:colorful/models/LocalUser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalMemoryService {
  final _secureStorageInstance = FlutterSecureStorage();
  static AuthStatus status = AuthStatus.undone;
  LocalMemoryService() {}

  Future<LocalUser?> getUserFromMemory() async {
    try {
      var currentUser = LocalUser.fromString(
          await _secureStorageInstance.read(key: "current user"));
      LocalUser.instance = currentUser;
      status = AuthStatus.complete;
      return currentUser;
    } catch (e) {
      log("user not found", error: e);
      status = AuthStatus.nuf;
    }
  }

  Future<void> saveUserToMemory() async {
    try {
      await _secureStorageInstance.write(
          key: "current user", value: LocalUser.instance.toString());
    } catch (e) {
      log("error while saving", error: e);
    }
  }
}
