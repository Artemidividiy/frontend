import 'package:colorful/enums/AuthStatus.dart';
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
    await _networkService.saveUserToNetwork();
  }

  Future authenticateUser(String email, String password) async {
    LocalUser.instance = LocalUser(password: password, email: email, uuid: "");
    await _networkService.authenticateUser(email, password);
    await _localMemoryService.saveUserToMemory();
  }
}
