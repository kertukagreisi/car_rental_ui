import 'package:car_rental_ui/generated_code/lib/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'intercept.dart';

class CarRentalApi {
  //to run on a physical device, set the local ip:
  //static String baseURL = 'http://192.168.1.46:8081';

  //to run on the Android Studio emulator:
  //static String baseURL = 'http://10.0.2.2:8081';

  static String baseURL = dotenv.get('BACKEND_PATH');
  static final ApiClient _apiClient = ApiClient(basePath: baseURL)..client = buildInterceptedClient();

  static final CarEndpointApi carEndpointApi = CarEndpointApi(_apiClient);

  static final BookingEndpointApi bookingEndpointApi = BookingEndpointApi(_apiClient);

  static final RatingEndpointApi ratingEndpointApi = RatingEndpointApi(_apiClient);

  static final UserEndpointApi userEndpointApi = UserEndpointApi(_apiClient);

  static final FileEndpointApi fileEndpointApi = FileEndpointApi(_apiClient);
}
