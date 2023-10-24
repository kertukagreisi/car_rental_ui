import 'package:car_rental_ui/generated_code/lib/api.dart';

import '../../api-client/api_client.dart';
import '../../shared/mvvm/view_model.dart';

class HomeViewModel extends ViewModel {
  late List<Car> cars = [];
  late List<Car> displayedCars = [];
  List<Brand> brandFiltersValues = [];
  String searchValue = '';
  bool hasBothFilters = false;

  @override
  Future<void> init() async {
    super.init();
    loadDataAsync(() async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    cars = (await CarRentalApi.carEndpointApi.carsAllGet())!;
    displayedCars = cars;
  }

  set addBrandFilter(Brand brand) {
    if (brandFiltersValues.length == 1 && brandFiltersValues.first == brand) {
      brandFiltersValues = [];
      displayedCars = cars;
    } else {
      if (brandFiltersValues.contains(brand)) {
        brandFiltersValues.remove(brand);
      } else {
        brandFiltersValues.add(brand);
      }
      displayedCars =
          cars.where((car) => brandFiltersValues.contains(Brand.values.firstWhere((brand) => brand == car.brand))).toList(growable: false);
    }
    displayedCars = displayedCars
        .where((car) => car.model.contains(searchValue.toUpperCase()) || car.brand.value.contains(searchValue.toUpperCase()))
        .toList(growable: false);
    notifyListeners();
  }

  Future<void> onSearch(String value) async {
    searchValue = value;
    if (brandFiltersValues.isNotEmpty) {
      displayedCars = displayedCars
          .where((car) => car.model.contains(searchValue.toUpperCase()) || car.brand.value.contains(searchValue.toUpperCase()))
          .toList(growable: false);
    } else {
      displayedCars = cars
          .where((car) => car.model.contains(searchValue.toUpperCase()) || car.brand.value.contains(searchValue.toUpperCase()))
          .toList(growable: false);
    }
    notifyListeners();
  }
}
