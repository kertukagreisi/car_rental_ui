import 'dart:convert';

import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> saveJsonObjectToSecureStorage(dynamic object) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final userJson = jsonEncode(object.toJson());

  await storage.write(key: 'object', value: userJson);
}

Future<void> removeObjectFromSecureStorage() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.delete(key: 'object');
}

// Retrieve a user object from secure storage
Future<dynamic> getObjectFromSecureStorage() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  const key = 'object';
  final userJson = await storage.read(key: key);

  if (userJson == null) {
    return null; // User data not found in storage
  }

  final userMap = jsonDecode(userJson);

  //replace the return value with object of type you want
  return User.fromJson(userMap);
}
