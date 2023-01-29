import 'dart:convert';

import 'color.dart';

class Hex {
  String hexValue;
  Hex({
    required this.hexValue,
  });

  Hex copyWith({
    String? hexValue,
  }) {
    return Hex(
      hexValue: hexValue ?? this.hexValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hexValue': hexValue,
    };
  }

  factory Hex.fromMap(Map<String, dynamic> map) {
    return Hex(
      hexValue: map['hexValue'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Hex.fromJson(String source) => Hex.fromMap(json.decode(source));

  @override
  String toString() => 'Hex(hexValue: $hexValue)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hex && other.hexValue == hexValue;
  }

  factory Hex.fromGroup({required Group group}) {
    String target = "";
    target += group.items[0].toRadixString(16);
    target += group.items[1].toRadixString(16);
    target += group.items[2].toRadixString(16);
    return Hex(hexValue: target);
  }

  @override
  int get hashCode => hexValue.hashCode;
}
