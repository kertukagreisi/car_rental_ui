import 'package:car_wash_ui/generated_code/lib/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CarWashApi {
  static String baseURL = dotenv.get('BACKEND_PATH');

  static final ApiClient _apiClient = ApiClient(basePath: baseURL);

  static final CarEndpointApi carEndpointApi = CarEndpointApi(_apiClient);

  static final OwnerEndpointApi ownerEndpointApi = OwnerEndpointApi(_apiClient);

  static final UserEndpointApi loginResourceApi = UserEndpointApi(_apiClient);
}
