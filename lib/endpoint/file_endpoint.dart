import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import '../shared/auth_service.dart';
import '../shared/locator.dart';

class FileService {
  FileService();

  static String baseURL = dotenv.get('BACKEND_PATH');

  Future<Uint8List> getUserProfilePicture(String userId) async {
    final response = await http.get(
      Uri.parse('$baseURL/files/users/$userId/profile-picture'),
      headers: {'Authorization': 'Bearer ${getIt<AuthService>().token}'},
    );

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load profile picture');
    }
  }

  Future<void> uploadProfilePicture(String userId, PlatformFile platformFile) async {
    final mimeType = lookupMimeType(platformFile.name) ?? 'application/octet-stream';
    final multiPartFile = http.MultipartFile.fromBytes(
      'file', // Field name for the file
      platformFile.bytes!,
      filename: platformFile.name,
      contentType: MediaType.parse(mimeType),
    );

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseURL/files/users/$userId/profile-picture'),
    );

    request.headers['Authorization'] = 'Bearer ${getIt<AuthService>().token}';
    request.files.add(multiPartFile);

    final streamedResponse = await request.send();

    if (streamedResponse.statusCode != 200) {
      throw Exception('Failed to upload profile picture');
    }
  }
}
