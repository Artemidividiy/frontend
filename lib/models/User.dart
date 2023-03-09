import 'dart:convert';

import 'package:colorful/models/LocalUser.dart';

class User {
  String uuid;
  User({
    required this.uuid,
  });

  User copyWith({
    String? uuid,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap(bool? authorized) {
    return {
      "email": LocalUser.instance!.email,
      "password": LocalUser.instance!.password,
      "authorized": authorized
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson(bool? authorized) => json.encode(toMap(authorized));

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(uuid: $uuid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.uuid == uuid;
  }

  @override
  int get hashCode => uuid.hashCode;
}
