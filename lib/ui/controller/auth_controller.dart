import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  static const String accessTokenKey = 'access-token';
  static const String userDataKey = 'user-data';

  static String? accessToken;
  static UserModel? userData;

  static Future<void> saveAccessToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(accessTokenKey, token);
    accessToken = token;
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(accessTokenKey);
    accessToken = token;
    return token;
  }

  static Future<void> saveUserData(UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(userDataKey, jsonEncode(userModel.toJson()));
    userData = userModel;
  }

  static Future<UserModel?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userEncodeData = sharedPreferences.getString(userDataKey);
    if (userEncodeData == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userEncodeData));
    userData = userModel;
    return userModel;
  }

  static bool isLoggedIn() {
    return accessToken != null;
  }

  static Future<void> clearUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(accessTokenKey);
    await sharedPreferences.remove(userDataKey);
    accessToken = null;
    userData = null;
  }
}

// Define your UserModel class
class UserModel {
  // Example fields
  final String name;
  final String email;

  UserModel({required this.name, required this.email});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
    );
  }
}
