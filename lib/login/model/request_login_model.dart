import 'dart:convert';

RequestLoginModel resquestLoginModelFromJson(String str) =>
    RequestLoginModel.fromJson(json.decode(str));

String resquestLoginModelToJson(RequestLoginModel data) =>
    json.encode(data.toJson());

class RequestLoginModel {
  String username;
  String password;

  RequestLoginModel({
    required this.username,
    required this.password,
  });

  factory RequestLoginModel.fromJson(Map<String, dynamic> json) =>
      RequestLoginModel(
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
