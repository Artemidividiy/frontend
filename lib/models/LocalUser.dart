import 'User.dart';

class LocalUser extends User {
  static LocalUser? instance;
  String? password;
  String email;
  int? id;
  LocalUser(
      {required this.password,
      required this.email,
      required String uuid,
      this.id})
      : super(uuid: uuid);

  String toString() {
    return "$email\n$password\n$id";
  }

  static LocalUser? fromString(String? string) {
    if (string == null) return null;
    List<String> strings = string.split("\n");
    return LocalUser(
        password: strings[1],
        id: int.parse(strings[2]),
        email: strings[0],
        uuid: "");
  }
}
