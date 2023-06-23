// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:scrapingdart/utils/static_data.dart';
import '../models/logout_response_model.dart';
import '../models/register_response_model.dart';
import '../models/user_profile_response_model.dart';
import '../utils/urls.dart';
import '../models/login_response_model.dart';
import '../models/user_data_response_model.dart';
import '../models/verify_otp_response_model.dart';
import '../models/message_response_model.dart';

class AuthServices {
  static var client = http.Client;

  static Future loginService(
      {required String email, required String password}) async {
    var body = json.encode({"email": email, "password": password});
    if (kDebugMode) {
      print("request : $body");
    }
    var response = await http.post(Uri.parse(loginUrl), body: body);
    if (kDebugMode) {
      print("LoginService : $loginUrl");
      print("Login RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("login service********");
    }
    return loginResponseFromJson(jsonString);
  }

  static Future registerService(
      {required String email,
      required String name,
      required String password}) async {
    var body = json.encode({
      "email": email,
      "password": password,
      "name": name,
      "password_confirmation": password,
      "type_user": "Normal",
      "profile_pic": ""
    });
    var response = await http.post(Uri.parse(registerUrl), body: body);
    if (kDebugMode) {
      print("registerUrl : $registerUrl");
      print("register RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("register service********");
    }
    return registerResponseFromJson(jsonString);
  }

  static Future verifyOtpService(
      {required String email, required String otp}) async {
    var body = json.encode({"email": email, "otp": otp});
    if (kDebugMode) {
      print("request : $body");
    }
    var response = await http.post(Uri.parse(verifyOtpUrl), body: body);
    if (kDebugMode) {
      print("verifyOtpUrl : $verifyOtpUrl");
      print("verifyOtpUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("verifyOtpUrl service********");
    }
    return verifyOtpResponseFromJson(jsonString);
  }

  static Future resetPasswordService(
      {required String email, required String password}) async {
    var body = json.encode({
      "email": email,
      "password": password,
      "password_confirmation": password
    });
    if (kDebugMode) {
      print("request : $body");
    }
    var response = await http.post(Uri.parse(resetPasswordUrl), body: body);
    if (kDebugMode) {
      print("resetPasswordUrl : $resetPasswordUrl");
      print("resetPasswordUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("resetPasswordUrl service********");
    }
    return messageResponseFromJson(jsonString);
  }

  static Future generateOtpService({required String email}) async {
    var body = json.encode({"email": email});
    if (kDebugMode) {
      print("request : $body");
    }
    var response = await http.post(Uri.parse(getOtpUrl), body: body);
    if (kDebugMode) {
      print("getOtpUrl : $getOtpUrl");
      print("getOtpUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("getOtpUrl service********");
    }
    return verifyOtpResponseFromJson(jsonString);
  }

  static Future<UserDataResponse> getUserDataService() async {
    var response = await http.get(Uri.parse(userDataUrl),
        headers: {'Authorization': 'Bearer ${StaticData.accessToken}'});
    if (kDebugMode) {
      print("userDataUrl : $userDataUrl");
      print("userDataUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("userDataUrl service********");
    }
    return userDataResponseFromJson(jsonString);
  }

  static Future<UserProfileResponse> getUserProfileById(
      {required userId}) async {
    var response = await http.get(Uri.parse("$userProfileByIdUrl/$userId"),
        headers: {'Authorization': 'Bearer ${StaticData.accessToken}'});
    if (kDebugMode) {
      print("userProfileByIdUrl : $userProfileByIdUrl");
      print("userProfileByIdUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("userProfileByIdUrl service********");
    }
    return userProfileResponseFromJson(jsonString);
  }

  static Future<MessageResponse> updateProfile(
      {required name,
      required about,
      required profilePic,
      required businessAbout,
      required language}) async {
    var body = json.encode({
      "name": name,
      "about": about,
      "language":language,
      "profile_pic": profilePic,
      "business_about": businessAbout
    });
    var response = await http.post(Uri.parse(updateProfileUrl),
        body: body,
        headers: {'Authorization': 'Bearer ${StaticData.accessToken}'});
    if (kDebugMode) {
      print("updateProfileUrl : $updateProfileUrl");
      print("updateProfileUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("updateProfileUrl service********");
    }
    return messageResponseFromJson(jsonString);
  }

  static Future logout() async {
    var response = await http.post(Uri.parse(logoutUrl),
        headers: {'Authorization': 'Bearer ${StaticData.accessToken}'});
    if (kDebugMode) {
      print("logout : $logoutUrl");
      print("logout RESPONSE : ${response.body}");
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("logout service********");
      }
      return logoutResponseFromJson(response.body);
    } else {
      if (kDebugMode) {
        print("error");
      }
      debugPrint("logout accor in profile service********");
      return null;
    }
  }

  static Future<MessageResponse> followUnfollowUser(
      {required userId, required follow}) async {
    var body = json.encode({"userid": userId, "follow": follow});
    if (kDebugMode) {
      print("request : $body");
    }
    var response = await http.post(Uri.parse(followUrl),
        body: body,
        headers: {'Authorization': 'Bearer ${StaticData.accessToken}'});
    if (kDebugMode) {
      print("followUrl : $followUrl");
      print("followUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    if (kDebugMode) {
      print("followUrl service********");
    }
    return messageResponseFromJson(jsonString);
  }

  static Future<MessageResponse> removeFollowerService({userId}) async {
    var response = await http.get(Uri.parse("$removefollowerUrl/$userId"),
        headers: {'Authorization': 'Bearer ${StaticData.accessToken}'});
    if (kDebugMode) {
      print("removefollowerUrl : $removefollowerUrl");
      print("removefollowerUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    return messageResponseFromJson(jsonString);
  }

  static Future<LoginResponse> googleLogin({required String gtoken}) async {
    var body = json.encode({
      "gtoken": gtoken,
    });
    if (kDebugMode) {
      print("request : $body");
    }
    var response = await http.post(Uri.parse(gloginUrl), body: body);
    if (kDebugMode) {
      print("gloginUrl : $gloginUrl");
      print("gloginUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    return loginResponseFromJson(jsonString);
  }

  static Future<LoginResponse> facebookLogin({required String ftoken}) async {
    var body = json.encode({
      "ftoken": ftoken,
    });
    if (kDebugMode) {
      print("request : $body");
    }
    var response = await http.post(Uri.parse(floginUrl), body: body);
    if (kDebugMode) {
      print("floginUrl : $gloginUrl");
      print("floginUrl RESPONSE : ${response.body}");
    }
    var jsonString = response.body;
    return loginResponseFromJson(jsonString);
  }
}
