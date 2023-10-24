import 'dart:convert';

import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> saveUserToSecureStorage(User user) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final userJson = jsonEncode(user.toJson());

  await storage.write(key: 'user', value: userJson);
}

// Retrieve a user object from secure storage
Future<User?> getUserFromSecureStorage() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  const key = 'user';
  final userJson = await storage.read(key: key);

  if (userJson == null) {
    return null; // User data not found in storage
  }

  final userMap = jsonDecode(userJson);
  return User.fromJson(userMap);
}
