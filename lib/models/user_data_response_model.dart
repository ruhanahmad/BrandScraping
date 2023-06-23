// To parse this JSON data, do
//
//     final userDataResponse = userDataResponseFromJson(jsonString);

import 'dart:convert';

UserDataResponse userDataResponseFromJson(String str) => UserDataResponse.fromJson(json.decode(str));

String userDataResponseToJson(UserDataResponse data) => json.encode(data.toJson());

class UserDataResponse {
  UserDataResponse({
    this.userdata,
  });

  Userdata? userdata;

  factory UserDataResponse.fromJson(Map<String, dynamic> json) => UserDataResponse(
    userdata: Userdata.fromJson(json["userdata"]),
  );

  Map<String, dynamic> toJson() => {
    "userdata": userdata!.toJson(),
  };
}

class Userdata {
  Userdata({
    this.userid,
    this.name,
    this.email,
    this.typeUser,
    this.profilePic,
    this.about,

    this.language,
  });

  int? userid;
  String? name;
  String? email;
  String? typeUser;
  String? profilePic;
  String? about;
  dynamic language;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    userid: json["userid"],
    name: json["name"],
    email: json["email"],
    typeUser: json["type_user"],
    profilePic: json["profile_pic"],
    about: json["about"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "name": name,
    "email": email,
    "type_user": typeUser,
    "profile_pic": profilePic,
    "about": about,
    "language": language,
  };
}
