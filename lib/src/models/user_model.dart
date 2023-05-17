// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String token;
  String username;
  String password;

  User({
    required this.token,
    required this.username,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "username": username,
        "password": password,
      };
}
