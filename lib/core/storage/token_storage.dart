import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _storage = FlutterSecureStorage();

  static const _tokenKey = "access_token";
  static const _onboardingKey = "onboarding_seen";
  /// 🧠 BUSINESS KEYS
  static const _businessSelectedKey = "business_selected";
  static const _businessModeKey = "business_mode";

  // ---------------------------
  // 🔐 TOKEN SECTION
  // ---------------------------

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ---------------------------
  // 🏢 BUSINESS SECTION
  // ---------------------------

  /// SAVE BUSINESS MODE
  static Future<void> saveBusinessMode(String mode) async {
    await _storage.write(key: _businessModeKey, value: mode);
  }

  /// GET BUSINESS MODE
  static Future<String?> getBusinessMode() async {
    return await _storage.read(key: _businessModeKey);
  }

  /// MARK BUSINESS SELECTED
  static Future<void> setBusinessModeSelected(bool value) async {
    await _storage.write(
      key: _businessSelectedKey,
      value: value.toString(),
    );
  }

  /// CHECK BUSINESS SELECTED
  static Future<bool> isBusinessSelected() async {
    final value = await _storage.read(key: _businessSelectedKey);
    return value == "true";
  }
// check on boarding
  static Future<void> setOnboardingSeen() async {
    await _storage.write(key: _onboardingKey, value: "true");
  }

  static Future<bool> isOnboardingSeen() async {
    final value = await _storage.read(key: _onboardingKey);
    return value == "true";
  }

  // ---------------------------
  // 🚪 LOGOUT CLEANUP
  // ---------------------------

  static Future<void> logout() async {
    await _storage.deleteAll();
  }
}