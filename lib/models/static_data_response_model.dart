// To parse this JSON data, do
//
//     final staticDataResponse = staticDataResponseFromJson(jsonString);

import 'dart:convert';

StaticDataResponse staticDataResponseFromJson(String str) => StaticDataResponse.fromJson(json.decode(str));

String staticDataResponseToJson(StaticDataResponse data) => json.encode(data.toJson());

class StaticDataResponse {
  StaticDataResponse({
    this.emotions,
    this.privacyData,
    this.languageList,
    this.trendingTags,
  });

  List<Emotion>? emotions;
  List<PrivacyDatum>? privacyData;
  List<LanguageList>? languageList;
  List<TrendingTag>? trendingTags;

  factory StaticDataResponse.fromJson(Map<String, dynamic> json) => StaticDataResponse(
    emotions: List<Emotion>.from(json["emotions"].map((x) => Emotion.fromJson(x))),
    privacyData: List<PrivacyDatum>.from(json["privacy_data"].map((x) => PrivacyDatum.fromJson(x))),
    languageList: List<LanguageList>.from(json["language_list"].map((x) => LanguageList.fromJson(x))),
    trendingTags: List<TrendingTag>.from(json["trending_tags"].map((x) => TrendingTag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "emotions": List<dynamic>.from(emotions!.map((x) => x.toJson())),
    "privacy_data": List<dynamic>.from(privacyData!.map((x) => x.toJson())),
    "language_list": List<dynamic>.from(languageList!.map((x) => x.toJson())),
    "trending_tags": List<dynamic>.from(trendingTags!.map((x) => x.toJson())),
  };
}

class Emotion {
  Emotion({
    this.id,
    this.bgColor,
    this.symbol,
    this.text,
  });

  int? id;
  String? bgColor;
  String? symbol;
  String? text;

  factory Emotion.fromJson(Map<String, dynamic> json) => Emotion(
    id: json["id"],
    bgColor: json["bg_color"],
    symbol: json["symbol"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bg_color": bgColor,
    "symbol": symbol,
    "text": text,
  };
}

class LanguageList {
  LanguageList({
    this.id,
    this.code,
    this.language,
  });

  int? id;
  String? code;
  String? language;

  factory LanguageList.fromJson(Map<String, dynamic> json) => LanguageList(
    id: json["id"],
    code: json["code"],
    language: json["language"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "code": code,
    "language": language,
  };
}

class PrivacyDatum {
  PrivacyDatum({
    this.id,
    this.privacyPost,
  });

  int? id;
  String? privacyPost;

  factory PrivacyDatum.fromJson(Map<String, dynamic> json) => PrivacyDatum(
    id: json["id"],
    privacyPost: json["privacy_post"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "privacy_post": privacyPost,
  };
}

class TrendingTag {
  TrendingTag({
    this.id,
    this.tags,
    this.active,
  });

  int? id;
  String? tags;
  int? active;

  factory TrendingTag.fromJson(Map<String, dynamic> json) => TrendingTag(
    id: json["id"],
    tags: json["tags"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tags": tags,
    "active": active,
  };
}
