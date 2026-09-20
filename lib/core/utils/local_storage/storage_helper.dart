import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageHelper {
  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(resetOnError: true),
  );
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'auth_refreshToken';

  Future<void> saveToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<String?> getToken() async {
    return await _secureStorage.read(
      key: _tokenKey,
    );
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(
      key: _refreshTokenKey,
    );
  }

  Future<void> deleteRefreshToken() async {
    await _secureStorage.delete(key: _refreshTokenKey);
  }

  Future<bool> isThereToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<bool> isThereRefreshToken() async {
    final refreshToken = await getRefreshToken();
    return refreshToken != null && refreshToken.isNotEmpty;
  }

  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
