import 'package:colorful/enums/AuthStatus.dart';
import 'package:colorful/models/LocalUser.dart';

import 'package:colorful/services/LocalMemoryService.dart';

class AuthViewModel {
  LocalMemoryService _LocalMemory = LocalMemoryService();

  late Future<LocalUser?> user;
  AuthViewModel() {
    user = _LocalMemory.getUserFromMemory();
  }

  registerNewUser({required LocalUser user}) async {
    LocalUser.instance = user;
    await _LocalMemory.saveUserToMemory();
  }

  authenticateUser() async {}
}
