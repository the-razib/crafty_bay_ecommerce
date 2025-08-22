import 'dart:convert';

import 'package:crafty_bay_ecommerce/features/auth/data/models/sign_in_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String _accessTokenKey = 'accessToken';
  final String _profileDataKey = 'userData';

  String? accessToken;
  User? userModel;

  Future<void> saveUserData(String accessToken, User model) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_accessTokenKey, accessToken);
    await sharedPreferences.setString(
      _profileDataKey,
      jsonEncode(model.toJson()),
    );
    userModel = model;
  }

  Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accessToken = sharedPreferences.getString(_accessTokenKey);
    userModel = User.fromJson(
      jsonDecode(sharedPreferences.getString(_profileDataKey)!),
    );
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(_accessTokenKey) != null) {
      await getUserData();
      return true;
    } else {
      return false;
    }
  }
}
