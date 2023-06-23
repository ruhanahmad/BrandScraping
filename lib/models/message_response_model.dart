// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

MessageResponse messageResponseFromJson(String str) => MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) => json.encode(data.toJson());

class MessageResponse {
  MessageResponse({
    this.status,
    this.message,
    this.result,
  });

  String? status;
  String? result;
  dynamic message;

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
    status: json["status"],
    message: json["message"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "result": result,
  };
}
