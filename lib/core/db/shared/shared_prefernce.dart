import 'package:shared_preferences/shared_preferences.dart';

class SetSharedPreferences {
  static Future storeAccessToken({required String accessToken}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }
}

class GetSharedPreferences {
  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }
}
