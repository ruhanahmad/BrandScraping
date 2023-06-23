// To parse this JSON data, do
//
//     final storiesByFollowedUsersResponse = storiesByFollowedUsersResponseFromJson(jsonString);

import 'dart:convert';

StoriesByFollowedUsersResponse storiesByFollowedUsersResponseFromJson(String str) => StoriesByFollowedUsersResponse.fromJson(json.decode(str));

String storiesByFollowedUsersResponseToJson(StoriesByFollowedUsersResponse data) => json.encode(data.toJson());

class StoriesByFollowedUsersResponse {
  StoriesByFollowedUsersResponse({
    this.status,
    this.followingUserStory,
    this.totalResult,
    this.totalComments,
  });

  String? status;
  List<FollowingUserStory>? followingUserStory;
  int? totalResult;
  int? totalComments;

  factory StoriesByFollowedUsersResponse.fromJson(Map<String, dynamic> json) => StoriesByFollowedUsersResponse(
    status: json["status"],
    followingUserStory: List<FollowingUserStory>.from(json["following_user_story"].map((x) => FollowingUserStory.fromJson(x))),
    totalResult: json["total_result"],
    totalComments: json["total_comments"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "following_user_story": List<dynamic>.from(followingUserStory!.map((x) => x.toJson())),
    "total_result": totalResult,
    "total_comments": totalComments,
  };
}

class FollowingUserStory {
  FollowingUserStory({
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
    this.isViewed,
    this.userData,
    this.comments,
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
  int? isViewed;
  List<UserDatum>? userData;
  List<Comment>? comments;

  factory FollowingUserStory.fromJson(Map<String, dynamic> json) => FollowingUserStory(
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
    isViewed: json["is_viewed"],
    userData: List<UserDatum>.from(json["user_data"].map((x) => UserDatum.fromJson(x))),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
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
    "user_data": List<dynamic>.from(userData!.map((x) => x.toJson())),
    "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
  };
}

class Comment {
  Comment({
    this.id,
    this.userid,
    this.storyId,
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
  int? storyId;
  String? comments;
  DateTime? createdOn;
  int? active;
  int? muserid;
  String? muserName;
  String? mprofilePic;
  String? commentType;
  List<CommentsReplyDatum>? commentsReplyData;
  int? totalReplyComments;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    userid: json["userid"],
    storyId: json["story_id"],
    comments: json["comments"],
    createdOn: DateTime.parse(json["created_on"]),
    active: json["active"],
    muserid: json["muserid"],
    muserName: json["muser_name"],
    mprofilePic: json["mprofile_pic"],
    commentType: json["comment_type"],
    commentsReplyData: List<CommentsReplyDatum>.from(json["comments_reply_data"].map((x) => CommentsReplyDatum.fromJson(x))),
    totalReplyComments: json["total_reply_comments"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "story_id": storyId,
    "comments": comments,
    "created_on": createdOn!.toIso8601String(),
    "active": active,
    "muserid": muserid,
    "muser_name": muserName,
    "mprofile_pic": mprofilePic,
    "comment_type": commentType,
    "comments_reply_data": List<dynamic>.from(commentsReplyData!.map((x) => x.toJson())),
    "total_reply_comments": totalReplyComments,
  };
}

class CommentsReplyDatum {
  CommentsReplyDatum({
    this.id,
    this.userid,
    this.storyId,
    this.comments,
    this.createdOn,
    this.active,
    this.commentType,
    this.commentsId,
    this.ruserid,
    this.ruserName,
    this.rprofilePic,
  });

  int? id;
  int? userid;
  int? storyId;
  String? comments;
  DateTime? createdOn;
  int? active;
  String? commentType;
  int? commentsId;
  int? ruserid;
  String? ruserName;
  String? rprofilePic;

  factory CommentsReplyDatum.fromJson(Map<String, dynamic> json) => CommentsReplyDatum(
    id: json["id"],
    userid: json["userid"],
    storyId: json["story_id"],
    comments: json["comments"],
    createdOn: DateTime.parse(json["created_on"]),
    active: json["active"],
    commentType: json["comment_type"],
    commentsId: json["comments_id"],
    ruserid: json["ruserid"],
    ruserName: json["ruser_name"],
    rprofilePic: json["rprofile_pic"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userid": userid,
    "story_id": storyId,
    "comments": comments,
    "created_on": createdOn!.toIso8601String(),
    "active": active,
    "comment_type": commentType,
    "comments_id": commentsId,
    "ruserid": ruserid,
    "ruser_name": ruserName,
    "rprofile_pic": rprofilePic,
  };
}

class UserDatum {
  UserDatum({
    this.id,
    this.name,
    this.profilePic,
    this.language,
    this.about,
  });

  int? id;
  String? name;
  String? profilePic;
  dynamic language;
  String? about;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
    id: json["id"],
    name: json["name"],
    profilePic: json["profile_pic"],
    language: json["language"],
    about: json["about"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_pic": profilePic,
    "language": language,
    "about": about,
  };
}
