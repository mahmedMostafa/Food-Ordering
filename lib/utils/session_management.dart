import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    return sharedPreferences;
  }

  static bool isLoggedIn() {
    if (sharedPreferences != null) {
      return sharedPreferences.getBool(IS_LOGIN_KEY) ?? false;
    } else {
      print("Shared is null");
      return false;
    }
  }

  static void saveUserData(String email, String name, String userId) async {
    await sharedPreferences.setString(EMAIL_KEY, email);
    await sharedPreferences.setString(NAME_KEY, name);
    await sharedPreferences.setBool(IS_LOGIN_KEY, true);
    await sharedPreferences.setString(USER_ID_KEY, userId);
  }

  //sign out from all socials as well
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await sharedPreferences.clear();
  }

  //VIP this function returns only a String & also we MUST make the if check till i get why :D
  static String getValue(String key) {
    if (sharedPreferences != null)
      return sharedPreferences.getString(key) ?? "";
    else
      return "Shared Prefs is nul!!";
  }
}
