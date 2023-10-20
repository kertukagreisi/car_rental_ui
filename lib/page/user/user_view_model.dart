import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../api-client/api_client.dart';
import '../../shared/mvvm/view_model.dart';

class UserViewModel extends ViewModel {
  late User user;

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    user = (await CarRentalApi.userEndpointApi.userLoginPost(loginRequest: LoginRequest(username: 'greisi', password: '123')))!;
  }
}
