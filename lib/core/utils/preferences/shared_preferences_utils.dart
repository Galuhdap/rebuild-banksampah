import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static const SHARED_BOX = "BS";
  static const SHARED_AUTH = "UserAuth";
  static const SHARED_AUTH_TOKEN = "AuthToken";
  static const SHARED_SETTING_ENUMERATOR = "SettingEnumerator";

  // Note: User Data
  static Future<void> addUser(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SHARED_AUTH, data);
  }

  static Future<String?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SHARED_AUTH);
  }

  static Future<void> deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(SHARED_AUTH);
  }

  // Note: Auth Token
  static Future<void> addAuthToken(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(SHARED_AUTH_TOKEN, data);
  }

  static Future<String?> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(SHARED_AUTH_TOKEN);
    //return "Bearer " + box.get(HIVE_AUTH_TOKEN);
  }

  static Future<void> deleteAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //return box.delete(HIVE_AUTH_TOKEN);
    await prefs.remove(SHARED_AUTH_TOKEN);
  }

  // Note: Setting Enumerator
  // static Future<void> addSettingEnumerator(
  //     List<SettingEnumeratorResponse?>? data) async {
  //   var box = await Hive.openBox(HIVE_BOX);
  //   List<String>? jsonData = data?.map((e) => jsonEncode(e?.toJson())).toList();
  //   await box.put(HIVE_SETTING_ENUMERATOR, jsonData ?? []);
  // }

  // static Future<List<SettingEnumeratorResponse?>?>
  //     getSettingEnumerator() async {
  //   var box = await Hive.openBox(HIVE_BOX);
  //   var result = box.get(HIVE_SETTING_ENUMERATOR);
  //   if (result is List<String>) {
  //     return result.map((e) {
  //       final jsonMap = jsonDecode(e) as Map<String, dynamic>;
  //       return SettingEnumeratorResponse.fromJson(jsonMap);
  //     }).toList();
  //   } else {
  //     return null;
  //   }
  // }

  // static Future<void> deleteSettingEnumerator() async {
  //   var box = await Hive.openBox(HIVE_BOX);
  //   return box.delete(HIVE_SETTING_ENUMERATOR);
  // }
}
