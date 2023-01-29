import 'User.dart';

class LocalUser extends User {
  static LocalUser? instance;
  String? password;
  String email;
  LocalUser({required this.password, required this.email, required String uuid})
      : super(uuid: uuid);

  String toString() {
    return "$uuid\n$email\n$password\n";
  }

  static LocalUser? fromString(String? string) {
    if (string == null) return null;
    List<String> strings = string.split("\n");
    return LocalUser(password: strings[2], uuid: strings[0], email: strings[1]);
  }
}
