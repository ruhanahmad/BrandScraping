// To parse this JSON data, do
//
//     final listOfFollowedUsersResponse = listOfFollowedUsersResponseFromJson(jsonString);

import 'dart:convert';

ListOfFollowedUsersResponse listOfFollowedUsersResponseFromJson(String str) => ListOfFollowedUsersResponse.fromJson(json.decode(str));

String listOfFollowedUsersResponseToJson(ListOfFollowedUsersResponse data) => json.encode(data.toJson());

class ListOfFollowedUsersResponse {
  ListOfFollowedUsersResponse({
    this.status,
    this.followingUser,
    this.totalResult,
    this.isFollowing,
  });

  String? status;
  List<FollowingUser>? followingUser;
  int? totalResult;
  int? isFollowing;

  factory ListOfFollowedUsersResponse.fromJson(Map<String, dynamic> json) => ListOfFollowedUsersResponse(
    status: json["status"],
    followingUser: List<FollowingUser>.from(json["following_user"].map((x) => FollowingUser.fromJson(x))),
    totalResult: json["total_result"],
    isFollowing: json["is_following"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "following_user": List<dynamic>.from(followingUser!.map((x) => x.toJson())),
    "total_result": totalResult,
    "is_following": isFollowing,
  };
}

class FollowingUser {
  FollowingUser({
    this.id,
    this.name,
    this.profilePic,
    this.language,
    this.isFollowing,
  });

  int? id;
  String? name;
  String? profilePic;
  List<Language>? language;
  int? isFollowing;

  factory FollowingUser.fromJson(Map<String, dynamic> json) => FollowingUser(
    id: json["id"],
    name: json["name"],
    profilePic: json["profile_pic"],
    language: json["language"]==null?[]: List<Language>.from(json["language"].map((x) => Language.fromJson(x))),
    isFollowing: json["is_following"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_pic": profilePic,
    "language": List<dynamic>.from(language!.map((x) => x.toJson())),
    "is_following": isFollowing,
  };
}

class Language {
  Language({
    this.code,
    this.language,
    this.languageId,
  });

  String? code;
  String? language;
  int? languageId;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
    code: json["code"],
    language: json["language"],
    languageId: json["language_id"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "language": language,
    "language_id": languageId,
  };
}
