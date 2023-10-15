import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CarRentalApi {
  static String baseURL = dotenv.get('BACKEND_PATH');

  static final ApiClient _apiClient = ApiClient(basePath: baseURL);

  static final CarEndpointApi carEndpointApi = CarEndpointApi(_apiClient);

  static final BookingEndpointApi bookingEndpointApi = BookingEndpointApi(_apiClient);

  static final UserEndpointApi userEndpointApi = UserEndpointApi(_apiClient);
}
