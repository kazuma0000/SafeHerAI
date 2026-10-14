import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SessionService {
  static const _key = 'safeher_signed_in';
  static const _tokenKey = 'safeher_access_token';
  final FlutterSecureStorage secureStorage;
  SessionService({FlutterSecureStorage? secureStorage}) : secureStorage = secureStorage ?? const FlutterSecureStorage();
  Future<bool> isSignedIn() async => (await SharedPreferences.getInstance()).getBool(_key) ?? false;
  Future<void> setSignedIn(bool value) async => (await SharedPreferences.getInstance()).setBool(_key, value);
  Future<String?> token() => secureStorage.read(key: _tokenKey);
  Future<void> saveToken(String value) async { await secureStorage.write(key: _tokenKey, value: value); await setSignedIn(true); }
  Future<void> clear() async { await secureStorage.delete(key: _tokenKey); await setSignedIn(false); }
}
