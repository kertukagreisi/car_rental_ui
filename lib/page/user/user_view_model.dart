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
    user = await CarRentalApi.userEndpointApi.userLoginPost(LoginRequest('greisi', '123'))!;
    displayedCars = user;
  }

  set addBrandFilter(Brand brand) {
    if (brandFiltersValues.length == 1 && brandFiltersValues.first == brand) {
      brandFiltersValues = [];
      displayedCars = user;
    } else {
      if (brandFiltersValues.contains(brand)) {
        brandFiltersValues.remove(brand);
      } else {
        brandFiltersValues.add(brand);
      }
      displayedCars =
          user.where((car) => brandFiltersValues.contains(Brand.values.firstWhere((brand) => brand == car.brand))).toList(growable: false);
    }
    notifyListeners();
  }

  Future<void> onSearch(String value) async {
    displayedCars =
        user.where((car) => car.model!.contains(value.toUpperCase()) || car.brand!.value.contains(value.toUpperCase())).toList(growable: false);
    notifyListeners();
  }
}
