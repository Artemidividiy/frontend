import 'package:colorful/enums/AuthMethod.dart';
import 'package:colorful/enums/AuthStatus.dart';
import 'package:colorful/enums/ValidationStatus.dart';
import 'package:colorful/models/LocalUser.dart';

import 'package:colorful/services/LocalMemoryService.dart';
import 'package:colorful/services/NetworkService.dart';

class AuthViewModel {
  LocalMemoryService _localMemoryService = LocalMemoryService();
  NetworkService _networkService = NetworkService();

  late Future<LocalUser?> user;
  AuthViewModel() {
    user = _localMemoryService.getUserFromMemory();
  }

  registerNewUser({required LocalUser user}) async {
    LocalUser.instance = user;
    await _localMemoryService.saveUserToMemory();
    await _networkService.authenticateUser(user.email, user.password!, false);
  }

  Future authenticateUser(String email, String password) async {
    LocalUser.instance = LocalUser(password: password, email: email, uuid: "");
    await _networkService.authenticateUser(email, password, true);
    await _localMemoryService.saveUserToMemory();
  }

  Future<ValidationStatus> validateUserData(
      String email, String password, AuthMethod method) async {
    switch (method) {
      case AuthMethod.Login:
        return await _networkService.fetchUser(email, password);
      default:
    }
    return ValidationStatus.Correct;
  }
}
