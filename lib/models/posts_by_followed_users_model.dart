// To parse this JSON data, do
//
//     final postByFollowedUsersResponse = postByFollowedUsersResponseFromJson(jsonString);

import 'dart:convert';

PostByFollowedUsersResponse postByFollowedUsersResponseFromJson(String str) => PostByFollowedUsersResponse.fromJson(json.decode(str));
class PostByFollowedUsersResponse {
  PostByFollowedUsersResponse({
    this.status,
    this.followingUserPost,
    this.totalResult,
  });

  String? status;
  List<FollowingUserPost>? followingUserPost;
  int? totalResult;

  factory PostByFollowedUsersResponse.fromJson(Map<String, dynamic> json) => PostByFollowedUsersResponse(
    status: json["status"],
    followingUserPost: List<FollowingUserPost>.from(json["following_user_post"].map((x) => FollowingUserPost.fromJson(x))),
    totalResult: json["total_result"],
  );


}

class FollowingUserPost {
  FollowingUserPost({
    this.postId,
    this.userid,
    this.mimeType,
    this.postFile,
    this.text,
    this.video,
    this.uploadedOn,
    this.active,
    this.publish,
    this.postType,
    this.emotionId,
    this.textColor,
    this.bgColor,
    this.symbol,
    this.emotionText,
    this.emotionBgColor,
    this.ratings,
    this.noRating,
    this.userData,
    this.comments,
    this.totalComments,
    this.totalViews,
    this.isViewed,
    this.userViews,
  });

  int? postId;
  int? userid;
  String? mimeType;
  List<String>? postFile;
  String? text;
  dynamic video;
  DateTime? uploadedOn;
  int? active;
  String? publish;
  String? postType;
  int? emotionId;
  String? textColor;
  String? bgColor;
  String? symbol;
  String? emotionText;
  String? emotionBgColor;
  dynamic ratings;
  dynamic noRating;
  List<User>? userData;
  List<Comment>? comments;
  int? totalComments;
  int? totalViews;
  dynamic isViewed;
  List<User>? userViews;

  factory FollowingUserPost.fromJson(Map<String, dynamic> json) => FollowingUserPost(
    postId: json["post_id"],
    userid: json["userid"],
    mimeType: json["mime_type"],
    postFile: json["post_file"]==null?[]: List<String>.from(json["post_file"].map((x) => x)),
    text: json["text"],
    video: json["video"],
    uploadedOn: DateTime.parse(json["uploaded_on"]),
    active: json["active"],
    publish: json["publish"],
    postType: json["post_type"],
    emotionId: json["emotion_id"],
    textColor: json["text_color"],
    bgColor: json["bg_color"],
    symbol: json["symbol"],
    emotionText: json["emotion_text"],
    emotionBgColor: json["emotion_bg_color"],
    ratings: json["ratings"],
    noRating: json["no_rating"],
    userData: List<User>.from(json["user_data"].map((x) => User.fromJson(x))),
    totalComments: json["total_comments"],
    totalViews: json["total_views"],
    isViewed:json["is_viewed"],
    userViews: List<User>.from(json["user_views"].map((x) => User.fromJson(x))),
  );

}

class Comment {
  Comment({
    this.id,
    this.userid,
    this.postId,
    this.comments,
    this.createdOn,
    this.active,
    this.muserid,
    this.muserName,
    this.mprofilePic,
    this.commentType,
    this.commentsReplyData,
    this.totalReplyComments,
  });

  int? id;
  int? userid;
  int? postId;
  String? comments;
  DateTime? createdOn;
  int? active;
  int? muserid;
  String? muserName;
  String? mprofilePic;
  String? commentType;
  List<dynamic>? commentsReplyData;
  int? totalReplyComments;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    userid: json["userid"],
    postId: json["post_id"],
    comments: json["comments"],
    createdOn: DateTime.parse(json["created_on"]),
    active: json["active"],
    muserid: json["muserid"],
    muserName: json["muser_name"],
    mprofilePic: json["mprofile_pic"],
    commentType: json["comment_type"],
    commentsReplyData: List<dynamic>.from(json["comments_reply_data"].map((x) => x)),
    totalReplyComments: json["total_reply_comments"],
  );


}


class User {
  User({
    this.id,
    this.name,
    this.profilePic,
    this.language,
    this.about,
  });

  int? id;
  String? name;
  String? profilePic;
  List<Language>? language;
  String? about;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    profilePic: json["profile_pic"],
    language: List<Language>.from(json["language"]==null?[]:json["language"].map((x) => Language.fromJson(x))),
    about: json["about"],
  );


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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
