import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../shared/auth_service.dart';
import '../shared/locator.dart';

class BookingService {
  BookingService();

  static String baseURL = dotenv.get('BACKEND_PATH');

  Future<void> deleteBooking(int bookingId) async {
    final response =
        await http.delete(Uri.parse('$baseURL/bookings/delete/$bookingId'), headers: {'Authorization': 'Bearer ${getIt<AuthService>().token}'});

    if (response.statusCode == 204) {
      return Future.value();
    } else {
      throw Exception('Failed to delete user');
    }
  }
}
