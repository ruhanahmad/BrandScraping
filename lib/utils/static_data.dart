import 'package:get/get.dart';

import '../models/list_of_following_users_response.dart';
import '../models/post_by_user_response_model.dart';
import '../models/static_data_response_model.dart';
import '../models/stories_by_followed_users_respones_model.dart';
import '../models/get_story_by_logged_in_user_model.dart';
import '../models/user_data_response_model.dart';
import '../models/posts_by_followed_users_model.dart';

class StaticData {
  static String key = "JsIh832B8QN8uZwlz3uYFg==";
  static String TEXT = "QH7il3+yt5sU/hE7YRquVA==";
  static String PDF = "RH/87n6ztpoV/xA6YBuvVQ==";

  static StaticDataResponse? staticData;
  static UserDataResponse? userDataResponse;
  static int? loggedInUserId;
  static PostByUserResponse? myPosts;
  static PostByFollowedUsersResponse? postByFollowedUsersResponse;
  static ListOfFollowingUsersResponse? listOfFollowingUsersResponse;
  static StoriesByFollowedUsersResponse? storiesByFollowedUsersResponse;
  static GetStoryByLoggedInUserResponse? getStoryByLoggedInUserResponse;
  static String? accessToken;
  static String? email;
/// jo logged in usewr hay uski id kya hay ? khaa store karwa rahi signin k baad 
  static void resetStaticData() {
    staticData = null;
    userDataResponse = null;
    loggedInUserId = null;
    myPosts = null;
    postByFollowedUsersResponse = null;
    listOfFollowingUsersResponse = null;
    storiesByFollowedUsersResponse = null;
    getStoryByLoggedInUserResponse = null;
    accessToken = null;
    email = null;
  }

  static List bgColorsList = [
    "#000000",
    "#FFB6C1", // Light pink
    "#87CEFA", // Light sky blue
    "#7FFFD4", // Aquamarine
    "#F0E68C", // Khaki
    "#BA55D3", // Medium orchid
    "#87CEEB", // Sky blue
    "#FFE4C4", // Bisque
    "#FFC0CB", // Pink
    "#FFFFFF"
  ];
}
