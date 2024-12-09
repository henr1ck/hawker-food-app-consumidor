import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserCredentialModel extends ChangeNotifier {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Future<String?> readToken() async {
    return await _storage.read(key: "access-token");
  }

  Future<void> writeToken(String accessToken) async {
    await _storage.write(key: "access-token", value: accessToken);
  }
}
