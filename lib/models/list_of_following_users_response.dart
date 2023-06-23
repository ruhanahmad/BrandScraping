// To parse this JSON data, do
//
//     final listOfFollowingUsersResponse = listOfFollowingUsersResponseFromJson(jsonString);

import 'dart:convert';

ListOfFollowingUsersResponse listOfFollowingUsersResponseFromJson(String str) => ListOfFollowingUsersResponse.fromJson(json.decode(str));

String listOfFollowingUsersResponseToJson(ListOfFollowingUsersResponse data) => json.encode(data.toJson());

class ListOfFollowingUsersResponse {
  ListOfFollowingUsersResponse({
    this.status,
    this.followingUser,
    this.totalResult,
    this.isFollowing,
  });

  String? status;
  List<FollowingUser>? followingUser;
  int? totalResult;
  int? isFollowing;

  factory ListOfFollowingUsersResponse.fromJson(Map<String, dynamic> json) => ListOfFollowingUsersResponse(
    status: json["status"],
    followingUser:  List<FollowingUser>.from(json["following_user"].map((x) => FollowingUser.fromJson(x))),
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
  List<dynamic>? language;
  int? isFollowing;

  factory FollowingUser.fromJson(Map<String, dynamic> json) => FollowingUser(
    id: json["id"],
    name: json["name"],
    profilePic: json["profile_pic"],
    language: json["language"],
    isFollowing: json["is_following"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_pic": profilePic,
    "language": language,
    "is_following": isFollowing,
  };
}
