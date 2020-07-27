import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SessionManagement {
  static const String EMAIL_KEY = "email_key";
  static const String NAME_KEY = "name_key";
  static const String USER_ID_KEY = "user_id_key";
  static const String IS_LOGIN_KEY = "login_key";

  static SharedPreferences sharedPreferences;

  static Future<SharedPreferences> get _instance async =>
      sharedPreferences ??= await SharedPreferences.getInstance();

  //this is called only once in main
  static Future<SharedPreferences> init() async {
    sharedPreferences = await _instance;
    print("done with shared prefs");
    return sharedPreferences;
  }

  static bool isLoggedIn() => sharedPreferences.getBool(IS_LOGIN_KEY) ?? false;

  static void saveUserData(String email, String name, String userId) async {
    await sharedPreferences.setString(EMAIL_KEY, email);
    await sharedPreferences.setString(NAME_KEY, name);
    await sharedPreferences.setBool(IS_LOGIN_KEY, true);
    await sharedPreferences.setString(USER_ID_KEY, userId);
  }

//  Future<bool> isLoggedIn() async {
//    return sharedPreferences.getBool(IS_LOGIN_KEY) ?? false;
//  }

  //VIP this function returns only a String
  static String getValue(String key) => sharedPreferences.getString(key);
}
