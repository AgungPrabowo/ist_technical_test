import 'dart:convert';

ResponseLoginModel responseLoginModelFromJson(String str) =>
    ResponseLoginModel.fromJson(json.decode(str));

String responseLoginModelToJson(ResponseLoginModel data) =>
    json.encode(data.toJson());

class ResponseLoginModel {
  int id;
  String username, email, firstName, lastName, gender, image, token;

  ResponseLoginModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.token,
  });

  factory ResponseLoginModel.fromJson(Map<String, dynamic> json) =>
      ResponseLoginModel(
        id: json["id"] ?? 0,
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        firstName: json["firstName"] ?? "",
        lastName: json["lastName"] ?? "",
        gender: json["gender"] ?? "",
        image: json["image"] ?? "",
        token: json["token"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "image": image,
        "token": token,
      };
}
