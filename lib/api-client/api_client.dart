import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'intercept.dart';

class CarRentalApi {
  static String baseURL = dotenv.get('BACKEND_PATH');
  static final ApiClient _apiClient = ApiClient(basePath: baseURL)..client = buildInterceptedClient();

  static final CarEndpointApi carEndpointApi = CarEndpointApi(_apiClient);

  static final BookingEndpointApi bookingEndpointApi = BookingEndpointApi(_apiClient);

  static final RatingEndpointApi ratingEndpointApi = RatingEndpointApi(_apiClient);

  static final UserEndpointApi userEndpointApi = UserEndpointApi(_apiClient);

  static final FileEndpointApi fileEndpointApi = FileEndpointApi(_apiClient);
}
