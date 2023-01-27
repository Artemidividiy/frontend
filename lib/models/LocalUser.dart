import 'User.dart';

class LocalUser extends User {
  static LocalUser? instance;
  String password;
  LocalUser({required this.password, required uuid, required username})
      : super(username: username, uuid: uuid);

  String toString() {
    return "$uuid\n$username\n$password\n";
  }

  factory LocalUser.fromString(String? string) {
    if (string == null) throw NullThrownError();
    List<String> strings = string.split("\n");
    return LocalUser(
        password: strings[2], uuid: strings[0], username: strings[1]);
  }
}
