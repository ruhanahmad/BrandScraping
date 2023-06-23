// To parse this JSON data, do
//
//     final getStoryByLoggedInUserResponse = getStoryByLoggedInUserResponseFromJson(jsonString);

import 'dart:convert';

GetStoryByLoggedInUserResponse getStoryByLoggedInUserResponseFromJson(String str) => GetStoryByLoggedInUserResponse.fromJson(json.decode(str));

String getStoryByLoggedInUserResponseToJson(GetStoryByLoggedInUserResponse data) => json.encode(data.toJson());

class GetStoryByLoggedInUserResponse {
  GetStoryByLoggedInUserResponse({
    this.storyData,
    this.totalStories,
  });

  List<StoryDatum>? storyData;
  int? totalStories;

  factory GetStoryByLoggedInUserResponse.fromJson(Map<String, dynamic> json) => GetStoryByLoggedInUserResponse(
    storyData: List<StoryDatum>.from(json["story_data"].map((x) => StoryDatum.fromJson(x))),
    totalStories: json["total_stories"],
  );

  Map<String, dynamic> toJson() => {
    "story_data": List<dynamic>.from(storyData!.map((x) => x.toJson())),
    "total_stories": totalStories,
  };
}

class StoryDatum {
  StoryDatum({
    this.storyId,
    this.userid,
    this.mimeType,
    this.postFile,
    this.uploadedOn,
    this.active,
    this.publish,
    this.postType,
    this.emotionId,
    this.symbol,
    this.emotionText,
    this.emotionBgColor,
    this.ratings,
    this.noRating,
    this.userData,
    this.totalComments,
  });

  int? storyId;
  int? userid;
  String? mimeType;
  List<String>? postFile;
  DateTime? uploadedOn;
  int? active;
  String? publish;
  String? postType;
  int? emotionId;
  String? symbol;
  String? emotionText;
  String? emotionBgColor;
  int? ratings;
  int? noRating;
  UserData? userData;
  int? totalComments;

  factory StoryDatum.fromJson(Map<String, dynamic> json) => StoryDatum(
    storyId: json["story_id"],
    userid: json["userid"],
    mimeType: json["mime_type"],
    postFile: List<String>.from(json["post_file"].map((x) => x)),
    uploadedOn: DateTime.parse(json["uploaded_on"]),
    active: json["active"],
    publish: json["publish"],
    postType: json["post_type"],
    emotionId: json["emotion_id"],
    symbol: json["symbol"],
    emotionText: json["emotion_text"],
    emotionBgColor: json["emotion_bg_color"],
    ratings: json["ratings"],
    noRating: json["no_rating"],
    userData: UserData.fromJson(json["user_data"]),
    totalComments: json["total_comments"],
  );

  Map<String, dynamic> toJson() => {
    "story_id": storyId,
    "userid": userid,
    "mime_type": mimeType,
    "post_file": List<dynamic>.from(postFile!.map((x) => x)),
    "uploaded_on": uploadedOn!.toIso8601String(),
    "active": active,
    "publish": publish,
    "post_type": postType,
    "emotion_id": emotionId,
    "symbol": symbol,
    "emotion_text": emotionText,
    "emotion_bg_color": emotionBgColor,
    "ratings": ratings,
    "no_rating": noRating,
    "user_data": userData!.toJson(),
    "total_comments": totalComments,
  };
}

class UserData {
  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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
