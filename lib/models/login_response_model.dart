// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.error,
    this.message,
    this.token,
    this.statusCode,
  });

  String? status;
  String? error;
  String? token;
  String? message;
  int? statusCode;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    status: json["status"],
    error: json["error"],
    token: json["token"],
    message: json["message"],
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "token": token,
    "message": message,
    "status_code": statusCode,
  };
}
