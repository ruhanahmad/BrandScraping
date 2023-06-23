// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) => UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) => json.encode(data.toJson());

class UserProfileResponse {
  UserProfileResponse({
    this.userdata,
  });

  Userdata? userdata;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
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
    this.businessAbout,
    this.language,
    this.rating,
    this.noRating,
    this.followers,
    this.following,
    this.isFollowing,
    this.ratingUsers,
  });

  String? userid;
  String? name;
  String? email;
  String? typeUser;
  String? profilePic;
  String? about;
  String? businessAbout;
  List<Language>? language;
  int? followers;
  int? rating;
  int? noRating;
  int? following;
  int? isFollowing;
  List<RatingUser>? ratingUsers;

  factory Userdata.fromJson(Map<String, dynamic> json) => Userdata(
    userid: json["userid"],
    name: json["name"],
    email: json["email"],
    typeUser: json["type_user"],
    profilePic: json["profile_pic"],
    about: json["about"],
    businessAbout: json["business_about"],
    language: List<Language>.from(json["language"].map((x) => Language.fromJson(x))),
    followers: json["followers"],
    rating: json["rating"],
    noRating: json["no_rating"],
    following: json["following"],
    isFollowing: json["is_following"],
    ratingUsers: List<RatingUser>.from(json["rating_users"].map((x) => RatingUser.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "name": name,
    "email": email,
    "type_user": typeUser,
    "profile_pic": profilePic,
    "about": about,
    "business_about": businessAbout,
    "language": List<dynamic>.from(language!.map((x) => x.toJson())),
    "followers": followers,
    "following": following,
    "is_following": isFollowing,
    "rating_users": List<dynamic>.from(ratingUsers!.map((x) => x.toJson())),
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

class RatingUser {
  RatingUser({
    this.name,
    this.profilePic,
    this.language,
    this.businessAbout,
    this.rated,
    this.rating,
    this.noRating,
    this.memberSince,
  });

  String? name;
  String? profilePic;
  List<Language>? language;
  String? businessAbout;
  int? rated;
  int? rating;
  int? noRating;
  DateTime? memberSince;

  factory RatingUser.fromJson(Map<String, dynamic> json) => RatingUser(
    name: json["name"],
    profilePic: json["profile_pic"],
    language: List<Language>.from(json["language"].map((x) => Language.fromJson(x))),
    businessAbout: json["business_about"],
    rated: json["rated"],
    rating: json["rating"],
    noRating: json["no_rating"],
    memberSince: DateTime.parse(json["member_since"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "profile_pic": profilePic,
    "language": List<dynamic>.from(language!.map((x) => x.toJson())),
    "business_about": businessAbout,
    "rated": rated,
    "rating": rating,
    "no_rating": noRating,
    "member_since": memberSince!.toIso8601String(),
  };
}
