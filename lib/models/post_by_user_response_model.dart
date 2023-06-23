// To parse this JSON data, do
//
//     final postByUserResponse = postByUserResponseFromJson(jsonString);

import 'dart:convert';

PostByUserResponse postByUserResponseFromJson(String str) => PostByUserResponse.fromJson(json.decode(str));

class PostByUserResponse {
  PostByUserResponse({
    this.postData,
    this.totalPosts,
  });

  List<PostDatum>? postData;
  int? totalPosts;

  factory PostByUserResponse.fromJson(Map<String, dynamic> json) => PostByUserResponse(
    postData: List<PostDatum>.from(json["post_data"].map((x) => PostDatum.fromJson(x))),
    totalPosts: json["total_posts"],
  );

}

class PostDatum {
  PostDatum({
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
    this.totalComments,
    this.totalViews,
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
  UserData? userData;
  int? totalComments;
  int? totalViews;
  List<UserView>? userViews;

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
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
    userData: UserData.fromJson(json["user_data"]),
    totalComments: json["total_comments"],
    totalViews: json["total_views"],
    userViews: List<UserView>.from(json["user_views"].map((x) => UserView.fromJson(x))),
  );

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

}




class UserView {
  UserView({
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

  factory UserView.fromJson(Map<String, dynamic> json) => UserView(
    id: json["id"],
    name: json["name"],
    profilePic: json["profile_pic"],
    language: json["language"],
    about: json["about"],
  );


}
