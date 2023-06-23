// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message({
    this.data,
    this.insertedAt,
    this.type,
    this.size,
    this.fileName,
    this.userId,
  });

  String? data;
  Timestamp? insertedAt;
  String? type;
  int? size;
  String? fileName;
  String? userId;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    data: json["data"],
    insertedAt: json["inserted_at"],
    type: json["type"],
    size: json["size"],
    fileName: json["file_name"],
    userId: json["user_id"],
  );


  Map<String, dynamic> toJson() => {
    "data": data,
    "inserted_at": insertedAt,
    "type": type,
    "user_id": userId,
    "size":size,
    "file_name":fileName
  };
}
