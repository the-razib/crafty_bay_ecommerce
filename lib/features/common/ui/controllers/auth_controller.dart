import 'dart:convert';

import 'package:crafty_bay_ecommerce/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  final String _accessTokenKey = 'accessToken';
  final String _profileDataKey = 'userData';

  String? accessToken;
  UserModel? userModel;

  Future<void> saveUserData(String accessToken, UserModel model) async {
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
    userModel = UserModel.fromJson(
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
