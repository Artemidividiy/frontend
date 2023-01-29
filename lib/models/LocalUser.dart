import 'User.dart';

class LocalUser extends User {
  static LocalUser? instance;
  String password;
  String email;
  LocalUser(
      {required this.password,
      required this.email,
      required String username,
      required String uuid})
      : super(username: username, uuid: uuid);

  String toString() {
    return "$uuid\n$username\n$email\n$password\n";
  }

  static LocalUser? fromString(String? string) {
    if (string == null) return null;
    List<String> strings = string.split("\n");
    return LocalUser(
        password: strings[3],
        uuid: strings[0],
        username: strings[1],
        email: strings[2]);
  }
}
