import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionController {
  static const String _tokenKey = 'token';

  static String? accessToken;

  static Future<void> saveToken(String token) async {
    final sharedPreferences =
    await SharedPreferences.getInstance();

    await sharedPreferences.setString(_tokenKey, token);

    accessToken = token;
  }

  static Future<void> getToken() async {
    final sharedPreferences =
    await SharedPreferences.getInstance();

    accessToken = sharedPreferences.getString(_tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final sharedPreferences =
    await SharedPreferences.getInstance();

    final token = sharedPreferences.getString(_tokenKey);

    if (token == null || token.isEmpty) {
      accessToken = null;
      return false;
    }

    // Check JWT expiry
    if (JwtDecoder.isExpired(token)) {
      await clearData();
      return false;
    }

    accessToken = token;
    return true;
  }

  static bool isTokenExpired() {
    if (accessToken == null || accessToken!.isEmpty) {
      return true;
    }

    return JwtDecoder.isExpired(accessToken!);
  }

  static Future<void> clearData() async {
    final sharedPreferences =
    await SharedPreferences.getInstance();

    await sharedPreferences.remove(_tokenKey);

    accessToken = null;
  }
}