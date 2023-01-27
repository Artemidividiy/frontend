import 'dart:convert';

class User {
  String username;
  String uuid;
  User({
    required this.username,
    required this.uuid,
  });

  User copyWith({
    String? username,
    String? uuid,
  }) {
    return User(
      username: username ?? this.username,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'uuid': uuid,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] ?? '',
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(username: $username, uuid: $uuid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.username == username && other.uuid == uuid;
  }

  @override
  int get hashCode => username.hashCode ^ uuid.hashCode;
}
