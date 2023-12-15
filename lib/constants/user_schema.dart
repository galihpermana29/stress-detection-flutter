import 'dart:convert';

import 'package:aplikasi_stress_detection/constants/data_schema.dart';

User userModelFromJson(String str) => User.fromJson(json.decode(str));
// List<User> userModelFromJson(String str) =>
//     List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? name;
  String? email;
  List<dynamic>? data;

  User({
    this.id,
    this.name,
    this.email,
    this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? null,
        name: json["name"] ?? null,
        email: json["email"] ?? null,
        data: (json["data"] != null)
            ? List<DataSound>.from(
                json["data"].map((x) => DataSound.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "data": (data != null) ? List<dynamic>.from(data!.map((x) => x)) : null,
      };
}
