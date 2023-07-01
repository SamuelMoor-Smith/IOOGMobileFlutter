import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class User {
  String username;
  String password;
  String apiUrl;
  String apiToken;

  User(
    this.username,
    this.password,
    this.apiUrl,
    this.apiToken,
  );

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'],
        apiUrl = json['apiUrl'],
        apiToken = json['apiToken'];

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'apiUrl': apiUrl,
        'apiToken': apiToken,
      };
}

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static createUser(username, password, apiUrl, apiToken) {
    return User(username, password, apiUrl, apiToken);
  }

  static Future addUser(User user) async =>
      await _storage.write(key: user.username, value: jsonEncode(user));

  static Future<User?> getUser(User user) async {
    return await getUsername(user.username);
  }

  static Future<User?> getUsername(String username) async {
    final user = await _storage.read(key: username);
    return user == null ? null : User.fromJson(json.decode(user));
  }
}
