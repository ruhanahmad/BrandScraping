// // To parse this JSON data, do
// //
// //     final registerResponse = registerResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));
//
// String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());
//
// class RegisterResponse {
//   RegisterResponse({
//     this.status,
//     this.message,
//     this.errors,
//   });
//
//   String? status;
//   dynamic message;
//   List<String>? errors;
//
//   factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
//     status: json["status"],
//     message: json["message"],
//     errors: List<String>.from(json["errors"].map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "errors": List<dynamic>.from(errors!.map((x) => x)),
//   };
// }
// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.status,
    this.message,
  });

  String? status;
  dynamic message;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
