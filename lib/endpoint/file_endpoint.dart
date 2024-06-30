import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../shared/auth_service.dart';
import '../shared/locator.dart';

class FileService {
  FileService();

  static String baseURL = dotenv.get('BACKEND_PATH');

  Future<Uint8List> getUserProfilePicture(String userId) async {
    final response =
        await http.get(Uri.parse('$baseURL/files/users/$userId/profile-picture'), headers: {'Authorization': 'Bearer ${getIt<AuthService>().token}'});

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load profile picture');
    }
  }
}
