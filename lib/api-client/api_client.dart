import 'package:car_rental_ui/generated_code/lib/api.dart';

class CarRentalApi {
  static String baseURL = 'http://10.0.2.2:8081';

  //dotenv.get('BACKEND_PATH');

  static final ApiClient _apiClient = ApiClient(basePath: baseURL);

  static final CarEndpointApi carEndpointApi = CarEndpointApi(_apiClient);

  static final BookingEndpointApi bookingEndpointApi =
      BookingEndpointApi(_apiClient);

  static final RatingEndpointApi ratingEndpointApi =
      RatingEndpointApi(_apiClient);

  static final UserEndpointApi userEndpointApi = UserEndpointApi(_apiClient);
}
