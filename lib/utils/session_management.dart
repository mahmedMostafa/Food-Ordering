import 'package:shared_preferences/shared_preferences.dart';

//TODO i'm not sure if these static variables leak memory
class SessionManagement {
  static const String EMAIL_KEY = "email_key";
  static const String NAME_KEY = "name_key";
  static const String USER_ID_KEY = "user_id_key";
  static const String IS_LOGIN_KEY = "login_key";

  static SharedPreferences sharedPreferences;

  SessionManagement() {
    getInstance();
  }

  static Future<SharedPreferences> getInstance() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
    return sharedPreferences;
  }

//  bool isLoggedIn() => sharedPreferences.getBool(key)

  void saveUserData(String email, String name, String userId) {
    sharedPreferences.setString(EMAIL_KEY, email);
    sharedPreferences.setString(NAME_KEY, name);
    sharedPreferences.setBool(IS_LOGIN_KEY, true);
    sharedPreferences.setString(USER_ID_KEY, userId);
  }

  bool isLoggedIn() {
    return sharedPreferences.getBool(IS_LOGIN_KEY) ?? false;
  }

  //VIP this function returns only a String
  String getValue(String key) => sharedPreferences.getString(key);
}
