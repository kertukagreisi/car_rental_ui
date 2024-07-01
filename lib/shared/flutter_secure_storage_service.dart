import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> saveToSecureStorage(String key, String value) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.write(key: key, value: value);
}

Future<void> removeFromSecureStorage(String key) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  await storage.delete(key: key);
}

Future<String?> getFromSecureStorage(String key) async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  return await storage.read(key: key);
}

Future<void> clearSecureStorage() async {
  const FlutterSecureStorage storage = FlutterSecureStorage();
  return await storage.deleteAll();
}
